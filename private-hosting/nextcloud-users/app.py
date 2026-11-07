"""Nextcloud users: list, allow (Google sign-in, no password), disable, delete, quota."""
import base64
import html
import json
import os
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

NC = os.environ["NEXTCLOUD_URL"]
HOST = os.environ["NEXTCLOUD_HOST"]
PROVIDER = os.environ.get("OIDC_PROVIDER_ID", "1")
# the real password, not an app password: user edits require a password confirmation
AUTH = "Basic " + base64.b64encode(f'{os.environ["NC_USER"]}:{os.environ["NC_PASSWORD"]}'.encode()).decode()
PROTECTED = {os.environ["NC_USER"]}


def ocs(method, path, data=None):
    body = urllib.parse.urlencode(data).encode() if data else None
    req = urllib.request.Request(f"{NC}/ocs/v2.php{path}?format=json", data=body, method=method, headers={
        "Authorization": AUTH, "OCS-APIRequest": "true", "Host": HOST, "X-Forwarded-Proto": "https"})
    try:
        with urllib.request.urlopen(req, timeout=20) as r:
            return json.load(r)["ocs"]["data"]
    except urllib.error.HTTPError as e:
        try:
            msg = json.load(e)["ocs"]["meta"]["message"]
        except Exception:
            msg = e.reason
        raise RuntimeError(f"{e.code}: {msg}") from None


def size(n):
    n = float(n or 0)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if n < 1024 or unit == "TB":
            return f"{n:.0f} {unit}" if unit == "B" else f"{n:.1f} {unit}"
        n /= 1024


def users():
    rows = []
    for uid, u in ocs("GET", "/cloud/users/details")["users"].items():
        q = u.get("quota") or {}
        last = u.get("lastLogin") or 0
        rows.append({
            "id": uid, "name": u.get("displayname") or uid, "enabled": u.get("enabled", True),
            "admin": "admin" in (u.get("groups") or []), "backend": u.get("backend", ""),
            "last": datetime.fromtimestamp(last / 1000, timezone.utc).strftime("%Y-%m-%d %H:%M") if last else "never",
            "used": size(q.get("used")), "quota": q.get("quota") if isinstance(q.get("quota"), str) else size(q.get("quota")),
        })
    return sorted(rows, key=lambda r: (r["id"] in PROTECTED, r["id"]))


CSS = """
:root{--bg:#eff1f5;--fg:#4c4f69;--card:#e6e9ef;--line:#ccd0da;--acc:#1e66f5;--red:#d20f39;--mute:#8c8fa1}
@media (prefers-color-scheme:dark){:root{--bg:#1e1e2e;--fg:#cdd6f4;--card:#181825;--line:#313244;--acc:#89b4fa;--red:#f38ba8;--mute:#7f849c}}
body{background:var(--bg);color:var(--fg);font:15px/1.5 system-ui,sans-serif;margin:0;padding:24px 16px}
main{max-width:960px;margin:auto}h1{font-size:22px;margin:0 0 4px}p.sub{color:var(--mute);margin:0 0 20px}
form.add{display:flex;gap:8px;margin-bottom:20px}input{flex:1;min-width:0;padding:8px 10px;border:1px solid var(--line);border-radius:8px;background:var(--card);color:var(--fg)}
button{padding:6px 12px;border:1px solid var(--line);border-radius:8px;background:var(--card);color:var(--fg);cursor:pointer}
button.primary{background:var(--acc);border-color:var(--acc);color:var(--bg)}button.danger{color:var(--red)}
.msg{padding:10px 12px;border-radius:8px;background:var(--card);margin-bottom:16px}.err{color:var(--red)}
.table{overflow-x:auto}table{width:100%;border-collapse:collapse}th,td{text-align:left;padding:8px;border-bottom:1px solid var(--line);white-space:nowrap}
th{color:var(--mute);font-weight:500}td.act form{display:inline}td.act input{width:70px;flex:none}.off{opacity:.5}.tag{color:var(--mute);font-size:12px}
"""


def page(rows, msg="", err=False):
    e = html.escape
    trs = []
    for r in rows:
        tags = (" <span class=tag>admin</span>" if r["admin"] else "") + (" <span class=tag>local</span>" if r["backend"] != "user_oidc" else "")
        if r["id"] in PROTECTED:
            act = "<span class=tag>break-glass account</span>"
        else:
            uid = e(r["id"])
            toggle = "disable" if r["enabled"] else "enable"
            act = (f"<form method=post action=/{toggle}><input type=hidden name=id value='{uid}'><button>{toggle}</button></form> "
                   f"<form method=post action=/quota><input type=hidden name=id value='{uid}'><input name=quota value='{e(r['quota'])}'><button>set</button></form> "
                   f"<form method=post action=/delete onsubmit=\"return confirm('Delete {uid} and all their files?')\"><input type=hidden name=id value='{uid}'><button class=danger>delete</button></form>")
        trs.append(f"<tr class='{'' if r['enabled'] else 'off'}'><td>{e(r['id'])}{tags}<br><span class=tag>{e(r['name'])}</span></td>"
                   f"<td>{e(r['last'])}</td><td>{e(r['used'])} / {e(r['quota'])}</td><td class=act>{act}</td></tr>")
    note = f"<div class='msg{' err' if err else ''}'>{e(msg)}</div>" if msg else ""
    return f"""<!doctype html><html lang=en><head><meta charset=utf-8><meta name=viewport content="width=device-width,initial-scale=1">
<title>Nextcloud users</title><style>{CSS}</style></head><body><main>
<h1>Nextcloud users</h1><p class=sub>Allowed Google accounts on <a href="https://{e(HOST)}">{e(HOST)}</a>. New accounts sign in with Google only, no password.</p>
{note}<form class=add method=post action=/add><input name=email type=email placeholder="google account email" required><button class=primary>allow</button></form>
<div class=table><table><tr><th>account</th><th>last login (UTC)</th><th>storage</th><th></th></tr>{''.join(trs)}</table></div>
</main></body></html>"""


class Handler(BaseHTTPRequestHandler):
    def send(self, code, body, ctype="text/html; charset=utf-8"):
        data = body.encode()
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        path, _, query = self.path.partition("?")
        if path == "/healthz":
            return self.send(200, "ok", "text/plain")
        if path != "/":
            return self.send(404, "not found", "text/plain")
        q = urllib.parse.parse_qs(query)
        try:
            self.send(200, page(users(), q.get("msg", [""])[0], q.get("err", [""])[0] == "1"))
        except Exception as ex:
            self.send(502, page([], f"Nextcloud unreachable: {ex}", True))

    def do_POST(self):
        form = urllib.parse.parse_qs(self.rfile.read(int(self.headers.get("Content-Length", 0))).decode())
        field = lambda k: form.get(k, [""])[0].strip()
        uid = urllib.parse.quote(field("id"), safe="")
        try:
            if self.path == "/add":
                email = field("email").lower()
                ocs("POST", "/apps/user_oidc/api/v1/user", {"providerId": PROVIDER, "userId": email, "email": email})
                msg = f"{email} allowed"
            elif field("id") in PROTECTED:
                raise RuntimeError("the break-glass account is managed by hand")
            elif self.path in ("/disable", "/enable"):
                ocs("PUT", f"/cloud/users/{uid}{self.path}")
                msg = f"{field('id')} {self.path[1:]}d"
            elif self.path == "/delete":
                ocs("DELETE", f"/cloud/users/{uid}")
                msg = f"{field('id')} deleted"
            elif self.path == "/quota":
                ocs("PUT", f"/cloud/users/{uid}", {"key": "quota", "value": field("quota")})
                msg = f"quota of {field('id')}: {field('quota')}"
            else:
                return self.send(404, "not found", "text/plain")
            err = "0"
        except Exception as ex:
            msg, err = str(ex), "1"
        self.send_response(303)
        self.send_header("Location", "/?" + urllib.parse.urlencode({"msg": msg, "err": err}))
        self.end_headers()

    def log_message(self, fmt, *args):
        print(f"{self.command} {self.path.split('?')[0]} {args[1] if len(args) > 1 else ''}", flush=True)


ThreadingHTTPServer(("", 8080), Handler).serve_forever()
