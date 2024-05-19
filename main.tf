
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
  location = "us-central1-a"
 project = "sampleproject"
  remove_default_node_pool = true
  initial_node_pools {
    name             = "primary-pool"
    initial_node_count = 1
  }
  initial_node_pools {
    name             = "secondary-pool"
    initial_node_count = 1
  }
}

resource "google_container_node_pool" "primary_pool" {
  name       = "primary-pool"
  location  = "us-central1-a"
  cluster   = google_container_cluster.primary.name
  project = "sampleproject"
  node_count = 1
  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "secondary_pool" {
  name       = "secondary-pool"
  location  = "us-central1-a"
  cluster   = google_container_cluster.primary.name
  project = "sampleproject"
  node_count = 1
  autoscaling {
    enabled = false
  }
}
