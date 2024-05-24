
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  project = "lumen-b-ctl-047"
  credentials = file("key.json")
}

resource "google_container_cluster" "primary" {
  name     = "test-cluster"
  location = "us-central1"

  networking_mode = "SYSTEM_DEFAULT"

  remove_default_node_pool = true

  initial_node_count = 1

  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "pools" {
  for_each = {
    "pool-0" = {
      name    = "pool-0"
      version = "latest"
    },
    "pool-1" = {
      name    = "pool-1"
      version = "latest"
    }
  }

  name       = each.value.name
  location  = "us-central1"
  cluster   = google_container_cluster.primary.name
  node_count = 1

  autoscaling {
    disabled = true
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
