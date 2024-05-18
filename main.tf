
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
 remove_default_node_pool = true

  node_pool {
    name       = "primary-node-pool"
    node_count = 1

    autoscaling {
      disabled = true
    }
  }

  node_pool {
    name       = "secondary-node-pool"
    node_count = 1

    autoscaling {
      disabled = true
    }
  }
}
