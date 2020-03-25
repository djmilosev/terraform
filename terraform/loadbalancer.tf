# ig
resource "google_compute_instance_group" "web-ig" {
  name = "web-ig"
  zone = var.zone
  instances =  "${google_compute_instance.web.*.self_link}"

  named_port {
    name = "http"
    port = "80"
  }
}

# hc
resource "google_compute_health_check" "web-hc" {
  name = "web-hc"
  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2

  http_health_check {
    port = "80"
    request_path = "/"
  }
}

# ilb
resource "google_compute_backend_service" "web-ilb" {
  name     = "web-ilb"
  protocol = "HTTP"
  health_checks = ["${google_compute_health_check.web-hc.self_link}"]

  backend {
    group = "${google_compute_instance_group.web-ig.self_link}"
  }
}

# url map (route requests to a backend service)
resource "google_compute_url_map" "web-url-map" {
  name            = "web-url-map"
  default_service = "${google_compute_backend_service.web-ilb.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "default"
  }

  path_matcher {
    name            = "default"
    default_service = "${google_compute_backend_service.web-ilb.self_link}"
  }
}

# target proxy (route incoming HTTP requests to a URL map)
resource "google_compute_target_http_proxy" "web-ilb-target-proxy" {
  name    = "web-ilb-target-proxy"
  url_map = "${google_compute_url_map.web-url-map.self_link}"
}

# ilb external ip
resource "google_compute_global_address" "web-ilb-external-ip" {
  name = "web-ilb-external-ip"
}

# fw (forward traffic to the load balancer)
resource "google_compute_global_forwarding_rule" "web-global-forwarding-rule" {
  name       = "web-global-forwarding-rule"
  target     = "${google_compute_target_http_proxy.web-ilb-target-proxy.self_link}"
  ip_address = "${google_compute_global_address.web-ilb-external-ip.address}"
  port_range = "80"
}

