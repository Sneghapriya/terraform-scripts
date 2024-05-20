
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

  networking_mode = "VPC_NATIVE"
  initial_node_count = 1

  ip_allocation_policy {
  }

  remove_default_node_pool = true

  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  cluster    = google_container_cluster.primary.name
  location  = "us-central1"
  project   = "sampleproject"

  autoscaling {
    enabled = false
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 100
    disk_type    = "pd-standard"
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  cluster    = google_container_cluster.primary.name
  location  = "us-central1"
  project   = "sampleproject"

  autoscaling {
    enabled = false
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 100
    disk_type    = "pd-standard"
  }
}
