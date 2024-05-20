
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

  networking_mode = "VPC_NATIVE"

}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name

  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb = 100
  }

  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name

  node_config {
    machine_type = "n1-standard-2"
    disk_size_gb = 100
  }

  autoscaling {
    enabled = false
  }
}
