resource "google_compute_firewall" "allow-http" {
  name = "allow-http"
  network = "default"

  allow {
      protocol = "tcp"
      ports = ["80"]
  }

  target_tags = ["allow-http"]
  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = "default"

  allow {
      protocol = "tcp"
      ports = ["22"]
  }

  target_tags = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]

}