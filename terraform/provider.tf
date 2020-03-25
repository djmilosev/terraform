provider "google" {
  project = var.project
  region = var.zone
  credentials = "${file("${var.credentials}/secrets.json")}"
}