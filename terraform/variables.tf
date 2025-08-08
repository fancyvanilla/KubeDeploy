variable "api_url" {
    description = "The API URL for CloudStack"
    type        = string
}

variable "api_key" {
    description = "The API key for CloudStack"
    type        = string
}

variable "secret" {
    description = "The secret key for CloudStack"
    type        = string
}
variable "zone" {
    description = "The name of the zone to deploy resources in"
    type        = string
}
variable "network_cidr" {
    description = "The CIDR for the network"
    type        = string
}
variable "network_offering" {
    description = "The network offering to use for the network"
    type        = string
}
variable "worker_count" {
    description = "The number of worker nodes to create"
    type        = number
}

variable "ssh_port" {
  type        = number
  description = "The SSH port for the control node"
}

variable "control_plane_service_offering" {
  type        = string
  description = "The service offering for the instances"
}
variable "worker_service_offering" {
  type        = string
  description = "The service offering for the worker nodes"
}

variable "template" {
  type        = string
  description = "The template to use for the instances"
}
variable "keypair"{
    type        = string
    description = "The name of the keypair to use for SSH access"
}