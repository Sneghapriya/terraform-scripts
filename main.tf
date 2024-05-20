
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

  networking {
    network = "default"
  }

  node_pool {
    name       = "default-pool"
    node_count = 1

    autoscaling {
      enabled = false
    }
  }

  node_pool {
    name       = "secondary-pool"
    node_count = 1

    autoscaling {
      enabled = false
    }
  }

  remove_default_node_pool = true
}
