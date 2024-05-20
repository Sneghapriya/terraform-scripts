
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

  networking_mode = "VPC_NATIVE"
  initial_node_count = 1

  ip_allocation_policy {
  }

  remove_default_node_pool = true

  node_pool {
    name       = "default-pool"
    node_count = 1
    autoscaling = false

    management {
      auto_repair  = true
      auto_upgrade = true
    }
  }

  node_pool {
    name       = "secondary-pool"
    node_count = 1
    autoscaling = false

    management {
      auto_repair  = true
      auto_upgrade = true
    }
  }
}
