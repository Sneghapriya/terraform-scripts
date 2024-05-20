
provider "google" {
  credentials = "path/to/credentials.json"
  project     = "lumen-b-ctl-047"
}

resource "google_compute_instance" "default" {
  name         = "test-vm"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
  }
}
