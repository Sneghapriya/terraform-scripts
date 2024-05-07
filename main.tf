resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.cluster_location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_name
  location   = var.cluster_location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    service_account = var.service_account
    oauth_scopes    = var.oauth_scopes
  }
}

