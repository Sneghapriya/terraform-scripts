
provider "google" {
  project = "sampleproject"
}

resource "google_container_cluster" "primary" {
 name     = "test-cluster"
 location = "us-central1-a"

  networking_mode = "VPC_NATIVE"
 remove_default_node_pool = true
 initial_node_count = 1

  ip_allocation_policy {
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name             = "primary-node-pool"
  cluster          = google_container_cluster.primary.name
  location          = google_container_cluster.primary.location
  node_count = 1

  autoscaling {}

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb = 100
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_container_node_pool" "secondary_nodes" {
  name             = "secondary-node-pool"
  cluster          = google_container_cluster.primary.name
  location          = google_container_cluster.primary.location
  node_count = 1

  autoscaling {}

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb = 100
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
