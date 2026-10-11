locals {
  records = {
    "lab.theoboursy.fr."       = var.vip
    "*.lab.theoboursy.fr."     = var.vip
    "lab.pub.theoboursy.fr."   = var.vps_ip
    "*.lab.pub.theoboursy.fr." = var.vps_ip
  }
}

resource "google_dns_record_set" "lab" {
  for_each = local.records

  project      = var.dns_project
  managed_zone = var.dns_zone
  name         = each.key
  type         = "A"
  ttl          = 300
  rrdatas      = [each.value]
}
