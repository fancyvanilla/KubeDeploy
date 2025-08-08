variable "zone" {
  type        = string
  description = "The CloudStack zone to use"
}

variable "worker_count" {
  type    = number
}

variable "network_ip_address"{
  type        = string
  description = "The public IP address ID of the network"
}
variable "ssh_port" {
  type        = number
  description = "The SSH port for the control node"
  default     = 2223
}

variable "control_plane_service_offering" {
  type        = string
  description = "The service offering for the instances"
}
variable "worker_service_offering" {
  type        = string
  description = "The service offering for the worker nodes"
}

variable "network_id" {
  type        = string
  description = "The network ID for the instances"
}

variable "ip_address_id" {
  type        = string
  description = "The public IP address ID"
}

variable "template" {
  type        = string
  description = "The template to use for the instances"
}
variable "keypair"{
    type        = string
    description = "The name of the keypair to use for SSH access"
}