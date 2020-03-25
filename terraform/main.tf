resource "google_compute_instance" "web" {
    count = "${var.node_count}"
    name  = "web-${count.index+1}"
    machine_type = var.machine_type
    zone = var.zone


    boot_disk {
        initialize_params {
            image = var.image
        }
    }

    network_interface {
        network = var.network

        access_config {
        // Ephemeral IP
        }
    }

    metadata = {
        sshKeys = "${var.ssh_user}:${file(var.ssh_key)}"
    }

    tags = ["allow-http", "allow-ssh"]
    
}

output "ilb_externap_ip" { value = "${google_compute_global_address.web-ilb-external-ip.address}" }
output "instances_external_ip" { value = "${google_compute_instance.web.*.network_interface.0.access_config.0.nat_ip}" }