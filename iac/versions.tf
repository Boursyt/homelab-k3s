terraform {
  required_version = ">= 1.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.0"
    }
  }

  backend "gcs" {
    bucket = "homelab-pi-510022-tfstate"
    prefix = "homelab"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}
