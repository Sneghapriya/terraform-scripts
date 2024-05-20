
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

  networking_mode = "k8s_pod_networking"

  workload_identity_config {
 workload_pool = "sampleproject.svc.id.goog"
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  location  = "us-central1-a"
  cluster   = google_container_cluster.primary.name
  project    = "sampleproject"
  node_count = 1

  autoscaling {}

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb = 100
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  location  = "us-central1-a"
  cluster   = google_container_cluster.primary.name
  project    = "sampleproject"
  node_count = 1

  autoscaling {}

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "n1-standard-2"
    disk_size_gb = 100
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
