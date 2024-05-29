
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file("key.json")
  project     = "lumen-b-ctl-047"
  region      = "us-central1"
}

resource "google_storage_bucket" "default" {
  name           = "automation-terraform"
  location       = "US-CENTRAL1"
  storage_class  = "STANDARD"
  uniform_bucket_level_access = true
}
