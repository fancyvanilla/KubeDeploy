terraform {
    required_providers {
        cloudstack = {
            source  = "shapeblue/cloudstack"
            version = "0.5.0"
        }
    }
}
provider "cloudstack" {
    api_url = var.api_url
    api_key = var.api_key
    secret_key = var.secret
}

module "network" {
  providers = {
    cloudstack = cloudstack
}
  source = "./modules/network"
  zone   = var.zone
  cidr   = var.network_cidr
  network_offering = var.network_offering
  ssh_port = var.ssh_port
  worker_count = var.worker_count
}

module "compute" {
  providers = {
    cloudstack = cloudstack
  }
  source = "./modules/compute"
  zone   = var.zone
  worker_count = var.worker_count
  network_ip_address = module.network.network_ip_address
  ssh_port = var.ssh_port
  control_plane_service_offering = var.control_plane_service_offering
  worker_service_offering = var.worker_service_offering
  network_id = module.network.network_id
  ip_address_id = module.network.ip_address_id
  template = var.template
  keypair = var.keypair
}