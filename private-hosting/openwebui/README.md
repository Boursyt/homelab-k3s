# Open WebUI

LLM chat (ai.lab) on OpenRouter and Gemini. Database in the NAS Postgres (pgvector).

| File | Content |
|---|---|
| `namespace.yaml` | `openwebui` namespace |
| `pvc-openwebui-data.yaml` | uploads |
| `deployment-openwebui.yaml` | Open WebUI |
| `service-openwebui.yaml` | Service |
| `deployment-tika.yaml` | Apache Tika: document text extraction and OCR |
| `service-tika.yaml` | Service |
| `ingress-openwebui.yaml` | `ai.lab.theoboursy.fr` |
| `secret-llm-keys.sops.yaml`, `secret-openwebui-db.sops.yaml`, `secret-openwebui-secret.sops.yaml` | Secrets encrypted with SOPS (see the root README) |
