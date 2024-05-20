
provider "google" {
  project = "sampleproject"
}

resource "google_container_cluster" "primary" {
 name     = "test-cluster"
 location = "us-central1-a"

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
  }
 remove_default_node_pool = true

  node_pool {
    name       = "primary-node-pool"
    node_count = 1

    config {
      machine_type = "e2-medium"
      disk_size_gb = 100
      oauth_scopes = [
 "https://www.googleapis.com/auth/compute",
 "https://www.googleapis.com/auth/devstorage.read_only",
 "https://www.googleapis.com/auth/logging.write",
 "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }

  node_pool {
    name       = "secondary-node-pool"
    node_count = 1

    config {
      machine_type = "e2-medium"
      disk_size_gb = 100
      oauth_scopes = [
 "https://www.googleapis.com/auth/compute",
 "https://www.googleapis.com/auth/devstorage.read_only",
 "https://www.googleapis.com/auth/logging.write",
 "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }
}
