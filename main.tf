
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_container_cluster" "cluster" {
  name     = "test-cluster"
  location = "us-central1"
  project  = "sampleproject"

  initial_node_count = 1

  ip_allocation_policy {
  }

  node_pool {
    name       = "default-pool"
    node_count = 1

    autoscaling {}
  }

  node_pool {
    name       = "secondary-pool"
    node_count = 1

    autoscaling {}
  }

  remove_default_node_pool = false
}
