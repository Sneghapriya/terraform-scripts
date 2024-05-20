
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

  networking_mode = "k8s_service"

}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  cluster    = google_container_cluster.primary.name
  location  = "us-central1"
 project   = "sampleproject"

  node_config {
    machine_type = "n1-standard-1"
  }
  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  cluster    = google_container_cluster.primary.name
  location  = "us-central1"
 project   = "sampleproject"

  node_config {
    machine_type = "n1-standard-2"
  }
  autoscaling {
    enabled = false
  }
}
