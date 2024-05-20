
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
 project  = "sampleproject"

  remove_default_node_pool = true
  initial_node_count       = 1
 networking_mode = "VPC_NATIVE"
  subnetwork = "projects/sampleproject/regions/us-central1/subnetworks/default"

  ip_allocation_policy {
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  cluster    = google_container_cluster.primary.name
  location  = "us-central1-a"
 project   = "sampleproject"

  node_config {
    machine_type = "n1-standard-1"
    disk_size    = 100
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  autoscaling {
    enabled = false
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  cluster    = google_container_cluster.primary.name
  location  = "us-central1-a"
 project   = "sampleproject"

  node_config {
    machine_type = "n1-standard-2"
    disk_size    = 100
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  autoscaling {
    enabled = false
  }
}
