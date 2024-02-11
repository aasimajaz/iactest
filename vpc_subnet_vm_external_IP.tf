#VPC + Subnet + VM with External IP
provider "google" {
  version = "4.50.0"
  credentials = file("instance-key.json")
  project = "using-terraf-157-85176b5a"
  region  = "us-central1"
  zone    = "us-central1-c"
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
  name         = "terraform-instance2"
  machine_type = "f1-micro"
  zone         = "us-central1-c"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private-subnet.name
    access_config {
    }
  }
}
