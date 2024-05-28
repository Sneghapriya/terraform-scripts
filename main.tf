
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = file("credentials.json")
  project     = "lumen-b-ctl-047"
}

resource "google_storage_bucket" "bucket" {
  name          = "automation-bucket-test-terraform1"
  location      = "US-CENTRAL1"
  force_destroy = false
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}
