provider "google" {
  credentials = file("service-account.json")
  project     = "your-project-id"
  region      = "us-central1"
}

resource "google_compute_instance" "example" {
  name         = "example-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  
  metadata_startup_script = <<-EOF
    #!/bin/bash
    echo "Password123" > /etc/my_app_password
  EOF
}

output "instance_password" {
  value = "Password123"
}
