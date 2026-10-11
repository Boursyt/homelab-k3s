resource "google_storage_bucket" "k3s_backup" {
  name                        = "${var.project}-k3s-backup"
  location                    = "EUROPE-WEST9"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_storage_bucket" "tfstate" {
  name                        = "${var.project}-tfstate"
  location                    = "EUROPE-WEST9"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
