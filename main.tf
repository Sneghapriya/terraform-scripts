
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file("keys.json")
  project     = "lumen-b-ctl-047"
}

resource "google_storage_bucket" "default" {
  name           = "terra-automation-bucket"
  location       = "us-central1"
  storage_class  = "STANDARD"
  uniform_bucket_level_access = true
}
