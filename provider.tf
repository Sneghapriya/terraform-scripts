terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.2.0"
    }
  }
}

provider "google" {
  credentials = file("/home/kirankumar_ra/gke/service-account.json")  
  project = "lumen-b-ctl-047"
  region  = "us-central1-a"
}