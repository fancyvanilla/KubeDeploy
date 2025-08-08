terraform {
    required_providers {
        cloudstack = {
            source  = "shapeblue/cloudstack"
            version = "0.5.0"
        }
    }
}
resource "cloudstack_instance" "control_node" {
  name             = "k8s-control-node"
  service_offering = var.control_plane_service_offering
  network_id       = var.network_id
  template         = var.template
  zone             = var.zone
}
resource "cloudstack_instance" "worker_nodes" {
  count            = var.worker_count
  name             = "k8s-worker-node-${count.index + 1}"
  service_offering = var.worker_service_offering
  network_id       = var.network_id
  template         = var.template
  zone             = var.zone
  keypair          = var.keypair
}

resource "cloudstack_port_forward" "ssh_access_control_node" {
  ip_address_id = var.ip_address_id

  forward {
    protocol           = "tcp"
    private_port       = 22
    public_port        = var.ssh_port
    virtual_machine_id = cloudstack_instance.control_node.id
  }
}

resource "cloudstack_port_forward" "ssh_access_worker_nodes" {
  count = var.worker_count

  ip_address_id = var.ip_address_id

  forward {
    protocol           = "tcp"
    private_port       = 22
    public_port        = var.ssh_port + count.index + 1
    virtual_machine_id = cloudstack_instance.worker_nodes[count.index].id
  }
}

resource "cloudstack_loadbalancer_rule" "default" {
  name          = "loadbalancer-rule-1"
  description   = "Loadbalancer rule for k8s control node"
  ip_address_id = var.ip_address_id
  algorithm     = "roundrobin"
  private_port  = 6443
  public_port   = 6443
  member_ids    = [cloudstack_instance.control_node.id]
}