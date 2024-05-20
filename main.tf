
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

  network = "default"

  node_pool {
    name       = "primary-node-pool"
    node_count = 1

    autoscaling = false

    management {
      auto_repair  = true
      auto_upgrade = true
    }
  }

  node_pool {
    name       = "secondary-node-pool"
    node_count = 1

    autoscaling = false

    management {
      auto_repair  = true
      auto_upgrade = true
    }
  }
}
