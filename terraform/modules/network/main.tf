terraform {
    required_providers {
        cloudstack = {
            source  = "cloudstack/cloudstack"
            version = "0.5.0"
        }
    }
}
resource "cloudstack_network" "default" {
  name             = "test-network"
  cidr             = var.cidr
  network_offering = var.network_offering
  zone             = var.zone
}
resource "cloudstack_ipaddress" "default" {
  depends_on = [cloudstack_network.default]
  network_id = cloudstack_network.default.id
}
resource "cloudstack_firewall" "default" {
  depends_on = [cloudstack_ipaddress.default]
  ip_address_id = cloudstack_ipaddress.default.id

  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol  = "tcp"
    ports     = local.ssh_ports
  }
}

output "network_ip_address" {
  value = cloudstack_ipaddress.default.ip_address
}
output "network_id" {
  value = cloudstack_network.default.id
}
output "ip_address_id" {
  value = cloudstack_ipaddress.default.id
}

resource "local_file" "vars_to_json" {
  content  = jsonencode(local.vars_to_json)
  filename = "${path.module}/vars.json"
}