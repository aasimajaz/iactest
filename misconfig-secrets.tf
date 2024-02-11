resource "google_compute_address" "default" {
  name   = "my-test-static-ip-address"
  region = "us-central1"
}

variable "database_password" { type = string description = "Password for the database" } resource "google_sql_database_instance" "example_instance" { name = "example-db-instance" database_version = "MYSQL_5_7" settings { tier = "db-n1-standard-1" } deletion_protection = false disk_type = "PD_SSD" } resource "google_sql_user" "example_user" { name = "example-user" instance = google_sql_database_instance.example_instance.name password = var.database_password # Not handling secrets properly } output "example_output" { value = google_sql_database_instance.example_instance.connection_name }
