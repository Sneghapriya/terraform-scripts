
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_container_cluster" "primary" {
  name     = "test-cluster"
  project  = "sampleproject"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1
 networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "secondary_nodes" {
  name       = "secondary-node-pool"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}
