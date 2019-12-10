
variable "vdc_project_id" {
  description = "The id the vdc porject - output of project module"
}


resource "openstack_networking_router_v2" "vdc_spine1" {
  name                = "vdc-spine1"
  admin_state_up      = true
  tenant_id           = "${var.vdc_project_id}"
}

resource "openstack_networking_router_v2" "vdc_leaf1" {
  name                = "vdc-leaf1"
  admin_state_up      = true
  tenant_id           = "${var.vdc_project_id}"
}

resource "openstack_networking_router_v2" "vdc_leaf2" {
  name                = "vdc-leaf2"
  admin_state_up      = true
  tenant_id           = "${var.vdc_project_id}"
}

#=====================================================
# Security Group for all leaf/spine networks

resource "openstack_networking_secgroup_v2" "vdc_security_grp1" {
  name        = "vdc-security-grp1"
  description = "Security group for leaf/spine connections"
  tenant_id   = "${var.vdc_project_id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_tcp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vdc_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_tcp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vdc_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_udp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vdc_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_udp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vdc_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_icmp_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vdc_security_grp1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "sgr_icmp_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = "0"
  port_range_max    = "0"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vdc_security_grp1.id}"
}


#=====================================================
# Network leaf1 - spine1

resource "openstack_networking_network_v2" "net_l1s1" {
  name           = "net-l1s1"
  admin_state_up = "true"
  tenant_id      = "${var.vdc_project_id}"
}

resource "openstack_networking_subnet_v2" "subnet_l1s1" {
  name       = "subnet_l1s1"
  network_id = "${openstack_networking_network_v2.net_l1s1.id}"
  cidr       = "210.168.11.0/24"
  ip_version = 4
  tenant_id  = "${var.vdc_project_id}"
}

resource "openstack_networking_port_v2" "port_1" {
  name           = "port_1"
  network_id     = "${openstack_networking_network_v2.net_l1s1.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_l1s1.id}"
    "ip_address" = "210.168.11.1"
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_n1s1" {
  router_id = "${openstack_networking_router_v2.vdc_spine1.id}"
  port_id  = "${openstack_networking_port_v2.port_1.id}"
}

resource "openstack_networking_port_v2" "port_2" {
  name           = "port_2"
  network_id     = "${openstack_networking_network_v2.net_l1s1.id}"
  admin_state_up = "true"

  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_l1s1.id}"
    "ip_address" = "210.168.11.10"
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_n1l1" {
  router_id = "${openstack_networking_router_v2.vdc_leaf1.id}"
  port_id  = "${openstack_networking_port_v2.port_2.id}"
}




#=====================================================
# Network leaf2 - spine1

resource "openstack_networking_network_v2" "net_l2s1" {
  name           = "net-l2s1"
  admin_state_up = "true"
  tenant_id      = "${var.vdc_project_id}"
}

resource "openstack_networking_subnet_v2" "subnet_l2s1" {
  name       = "subnet_l2s1"
  network_id = "${openstack_networking_network_v2.net_l2s1.id}"
  cidr       = "210.168.21.0/24"
  ip_version = 4
  tenant_id  = "${var.vdc_project_id}"
}

resource "openstack_networking_port_v2" "port_l2s1_1" {
  name           = "port_1"
  network_id     = "${openstack_networking_network_v2.net_l2s1.id}"
  admin_state_up = "true"
  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_l2s1.id}"
    "ip_address" = "210.168.21.1"
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_n2s1" {
  router_id = "${openstack_networking_router_v2.vdc_spine1.id}"
  port_id  = "${openstack_networking_port_v2.port_l2s1_1.id}"
}

resource "openstack_networking_port_v2" "port_l2s1_2" {
  name           = "port_l2s1_2"
  network_id     = "${openstack_networking_network_v2.net_l2s1.id}"
  admin_state_up = "true"

  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.subnet_l2s1.id}"
    "ip_address" = "210.168.21.10"
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_n2l2" {
  router_id = "${openstack_networking_router_v2.vdc_leaf2.id}"
  port_id  = "${openstack_networking_port_v2.port_l2s1_2.id}"
}


