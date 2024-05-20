
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
  location = "us-central1"
 project  = "sampleproject"

  remove_default_node_pool = true
  initial_node_pool {
    name       = "primary-node-pool"
    node_count = 1
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  location  = "us-central1"
  cluster   = google_container_cluster.primary.name
  project   = "sampleproject"
  node_count = 1
  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  location  = "us-central1"
  cluster   = google_container_cluster.primary.name
  project   = "sampleproject"
  node_count = 1
  autoscaling {
    enabled = false
  }
}
