
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
  initial_node_count       = 1

  networking_mode = "k8s_ip_aliases_with_routes"
}

resource "google_container_node_pool" "pool_one" {
  name       = "pool-one"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool_two" {
  name       = "pool-two"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    enabled = false
  }
}
