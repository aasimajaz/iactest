terraform {
  cloud {
    organization = "ajaza"

    workspaces {
      name = "my-test-env"
    }
  }
}
provider "google" {
        project = "deploying-in-269-bc2de9c1"
}


resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "private-subnet" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.10.100.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
  private_ip_google_access = "true"
  }

resource "google_compute_instance" "app_instance" {
 count = 3
  name         = "app-instance-${count.index}"
  machine_type = "f1-micro"
  zone         = "us-central1-c"
  tags = ["type","app"]
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private-subnet.name
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
allow {
    protocol = "icmp"
  }
allow {
    protocol = "tcp"
    ports    = ["22"]
  }
target_tags = ["app"]
  source_ranges = ["0.0.0.0/0"]
