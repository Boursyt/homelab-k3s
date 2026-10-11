resource "google_service_account" "k3s_backup" {
  account_id   = "k3s-backup"
  display_name = "k3s etcd snapshots -> GCS"
}

resource "google_storage_bucket_iam_member" "k3s_backup_objects" {
  bucket = google_storage_bucket.k3s_backup.name
  role   = "roles/storage.objectAdmin"
  member = google_service_account.k3s_backup.member
}

resource "google_storage_bucket_iam_member" "k3s_backup_list" {
  bucket = google_storage_bucket.k3s_backup.name
  role   = "roles/storage.legacyBucketReader"
  member = google_service_account.k3s_backup.member
}

resource "google_service_account" "cert_manager_dns" {
  project    = var.dns_project
  account_id = "traefik-dns"
}

resource "google_project_iam_member" "cert_manager_dns" {
  project = var.dns_project
  role    = "roles/dns.admin"
  member  = google_service_account.cert_manager_dns.member
}
