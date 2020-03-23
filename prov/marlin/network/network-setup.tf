
data "openstack_identity_project_v3" "marlin_project" {
  name = "marlin"
}

resource "openstack_networking_router_v2" "rtr1" {
  name                = "rtr1"
  admin_state_up      = true
  tenant_id           = "${data.openstack_identity_project_v3.marlin_project.id}"
}

#=====================================================
# Security Group for all leaf/spine networks

resource "openstack_networking_secgroup_v2" "marlin_security_grp1" {
  name        = "marlin-security-grp1"
  description = "Security group for leaf/spine connections"
  tenant_id   = "${data.openstack_identity_project_v3.marlin_project.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_tcp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.marlin_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_tcp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.marlin_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_udp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.marlin_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_udp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.marlin_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_icmp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.marlin_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_icmp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.marlin_security_grp1.id}"
}


#=====================================================
# Network net1

resource "openstack_networking_network_v2" "net1" {
  name           = "net1"
  admin_state_up = "true"
  tenant_id      = "${data.openstack_identity_project_v3.marlin_project.id}"
}

resource "openstack_networking_subnet_v2" "subnet1" {
  name       = "subnet1"
  network_id = "${openstack_networking_network_v2.net1.id}"
  cidr       = "210.168.110.0/24"
  ip_version = 4
  tenant_id  = "${data.openstack_identity_project_v3.marlin_project.id}"
}

resource "openstack_networking_port_v2" "port1" {
  name           = "port1"
  network_id     = "${openstack_networking_network_v2.net1.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet1.id}"
    "ip_address" = "210.168.110.1"
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_n1s1" {
  router_id = "${openstack_networking_router_v2.rtr1.id}"
  port_id  = "${openstack_networking_port_v2.port1.id}"
}


#=====================================================
# Network net2

resource "openstack_networking_network_v2" "net2" {
  name           = "net2"
  admin_state_up = "true"
  tenant_id      = "${data.openstack_identity_project_v3.marlin_project.id}"
}

resource "openstack_networking_subnet_v2" "subnet2" {
  name       = "subnet2"
  network_id = "${openstack_networking_network_v2.net2.id}"
  cidr       = "210.168.120.0/24"
  ip_version = 4
  tenant_id  = "${data.openstack_identity_project_v3.marlin_project.id}"
}

resource "openstack_networking_port_v2" "port2" {
  name           = "port2"
  network_id     = "${openstack_networking_network_v2.net2.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet2.id}"
    "ip_address" = "210.168.120.1"
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_n2s1" {
  router_id = "${openstack_networking_router_v2.rtr1.id}"
  port_id  = "${openstack_networking_port_v2.port2.id}"
}


output "net1_id" { value = "${openstack_networking_network_v2.net1.id}"}
output "subnet1_id" { value = "${openstack_networking_subnet_v2.subnet1.id}"}
output "net2_id" { value = "${openstack_networking_network_v2.net2.id}"}
output "subnet2_id" { value = "${openstack_networking_subnet_v2.subnet2.id}"}
