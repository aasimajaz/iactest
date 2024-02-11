provider "google" {
  credentials = file("account.json")
  project     = "your-project-id"
  region      = "us-central1"
}

resource "google_compute_instance" "example" {
  name         = "example-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Public IP address is assigned by default
    }
  }

  tags = ["web", "dev"]
}
