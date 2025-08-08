variable network_offering {
    description = "The network offering to use for the network"
    type        = string
}

variable cidr {
    description = "The CIDR for the network"
    type        = string
}

variable "zone" {
  type        = string
  description = "The CloudStack zone to use"
}

variable "worker_count" {
  type = number
}

variable "ssh_port" {
  type        = number
  description = "The SSH port for the control node"
}

locals {
  ssh_ports = ["6443", "${var.ssh_port}-${var.ssh_port + var.worker_count}"]
  vars_to_json ={
    ip_address = cloudstack_ipaddress.default.ip_address
    ssh_port = var.ssh_port
    worker_count = var.worker_count
  }
}