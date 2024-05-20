
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

  workload_identity_config {
    workload_pool = "${google_project.project.project_id}.svc.workload.identity"
  }
}

resource "google_container_node_pool" "pool1" {
  name       = "pool-1"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {}
}

resource "google_container_node_pool" "pool2" {
  name       = "pool-2"
  location  = "us-central1"
  project   = "sampleproject"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {}
}

resource "google_project" "project" {
  project_id = "sampleproject"
}
