terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}

resource "google_container_cluster" "primary" {
  name     = "test_cluster"
  location = "us-central1-a"
 project  = ""

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
  }
  remove_default_node_pool = true

  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location  = "us-central1-a"
  project   = ""
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {}

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 100
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}