
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

resource "google_container_cluster" "primary" {
  name     = "test-cluster"
  location = "us-central1-c"

  initial_node_count = 2

  node_config {
    machine_type = "n1-standard-1"
  }
}
