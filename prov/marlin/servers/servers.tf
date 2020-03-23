
data "openstack_images_image_v2" "cirros" {
  name = "Cirros"
}


variable "net1_id" {
  description = "The ID of net1 - output of network module"
}

variable "subnet1_id" {
  description = "The ID of subnet1 - output of network module"
}

variable "net2_id" {
  description = "The ID of net2 - output of network module"
}

variable "subnet2_id" {
  description = "The ID of subnet2 - output of network module"
}


############################################################
# Volumes
resource "openstack_blockstorage_volume_v3" "vm_volume_1" {
  name        = "vm-volume-1"
  description = "Volume for VM1"
  size        = 40
}

resource "openstack_blockstorage_volume_v3" "vm_volume_2" {
  name        = "vm-volume-2"
  description = "Volume for VM2"
  size        = 40
}

resource "openstack_blockstorage_volume_v3" "vm_volume_3" {
  name        = "vm-volume-3"
  description = "Volume for VM3"
  size        = 40
}

resource "openstack_blockstorage_volume_v3" "vm_volume_4" {
  name        = "vm-volume-4"
  description = "Volume for VM4"
  size        = 40
}



############################################################
#  VM1
resource "openstack_compute_instance_v2" "vm1" {
  name        = "vm1"
  image_name  = "Cirros"
  flavor_name = "m1.small"
  security_groups = ["marlin-security-grp1"]
  network {
    port = "${openstack_networking_port_v2.port_vm1.id}"
  }

  # Install system in volume
  block_device {
    volume_size           = "40"
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = "${data.openstack_images_image_v2.cirros.id}"
    delete_on_termination = true
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_vm1" {
  name           = "port-instance-vm1"
  network_id     = "${var.net1_id}"
  admin_state_up = true
  fixed_ip {
    subnet_id = "${var.subnet1_id}"
  }
}


resource "openstack_compute_volume_attach_v2" "vm1_vol1" {
  instance_id = "${openstack_compute_instance_v2.vm1.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.vm_volume_1.id}"
}


# Create floating ip
#resource "openstack_networking_floatingip_v2" "vm1" {
#  pool = var.external_network
#}

# Attach floating ip to instance
#resource "openstack_compute_floatingip_associate_v2" "vm1" {
#  floating_ip = openstack_networking_floatingip_v2.vm1.address
#  instance_id = openstack_compute_instance_v2.vm1.id
#}


############################################################
#  VM2
resource "openstack_compute_instance_v2" "vm2" {
  name        = "vm2"
  image_name  = "Cirros"
  flavor_name = "m1.small"
  security_groups = ["marlin-security-grp1"]
  network {
    port = "${openstack_networking_port_v2.port_vm2.id}"
  }

  # Install system in volume
  block_device {
    volume_size           = "40"
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = "${data.openstack_images_image_v2.cirros.id}"
    delete_on_termination = true
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_vm2" {
  name           = "port-instance-vm2"
  network_id     = "${var.net1_id}"
  admin_state_up = true
  fixed_ip {
    subnet_id = "${var.subnet1_id}"
  }
}

resource "openstack_compute_volume_attach_v2" "vm2_vol2" {
  instance_id = "${openstack_compute_instance_v2.vm2.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.vm_volume_2.id}"
}



############################################################
#  VM3
resource "openstack_compute_instance_v2" "vm3" {
  name        = "vm3"
  image_name  = "Cirros"
  flavor_name = "m1.small"
  security_groups = ["marlin-security-grp1"]
  network {
    port = "${openstack_networking_port_v2.port_vm3.id}"
  }

  # Install system in volume
  block_device {
    volume_size           = "40"
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = "${data.openstack_images_image_v2.cirros.id}"
    delete_on_termination = true
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_vm3" {
  name           = "port-instance-vm3"
  network_id     = "${var.net2_id}"
  admin_state_up = true
  fixed_ip {
    subnet_id = "${var.subnet2_id}"
  }
}

resource "openstack_compute_volume_attach_v2" "vm1_vol3" {
  instance_id = "${openstack_compute_instance_v2.vm3.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.vm_volume_3.id}"
}

############################################################
#  VM4
resource "openstack_compute_instance_v2" "vm4" {
  name        = "vm4"
  image_name  = "Cirros"
  flavor_name = "m1.small"
  security_groups = ["marlin-security-grp1"]
  network {
    port = "${openstack_networking_port_v2.port_vm4.id}"
  }

  # Install system in volume
  block_device {
    volume_size           = "40"
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = "${data.openstack_images_image_v2.cirros.id}"
    delete_on_termination = true
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_vm4" {
  name           = "port-instance-vm4"
  network_id     = "${var.net2_id}"
  admin_state_up = true
  fixed_ip {
    subnet_id = "${var.subnet2_id}"
  }
}
resource "openstack_compute_volume_attach_v2" "vm4_vol4" {
  instance_id = "${openstack_compute_instance_v2.vm4.id}"
  volume_id   = "${openstack_blockstorage_volume_v3.vm_volume_4.id}"
}



############################################################
#  VM5
resource "openstack_compute_instance_v2" "vm5" {
  name        = "vm5"
  image_name  = "Cirros"
  flavor_name = "m1.small"
  security_groups = ["marlin-security-grp1"]
  network {
    port = "${openstack_networking_port_v2.port_vm5.id}"
  }

  # Install system in volume
  block_device {
    volume_size           = "40"
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = "${data.openstack_images_image_v2.cirros.id}"
    delete_on_termination = true
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_vm5" {
  name           = "port-instance-vm5"
  network_id     = "${var.net2_id}"
  admin_state_up = true
  fixed_ip {
    subnet_id = "${var.subnet2_id}"
  }
}


############################################################
#  VM6
resource "openstack_compute_instance_v2" "vm6" {
  name        = "vm6"
  image_name  = "Cirros"
  flavor_name = "m1.small"
  security_groups = ["marlin-security-grp1"]
  network {
    port = "${openstack_networking_port_v2.port_vm6.id}"
  }

  # Install system in volume
  block_device {
    volume_size           = "40"
    destination_type      = "volume"
    delete_on_termination = true
    source_type           = "image"
    uuid                  = "${data.openstack_images_image_v2.cirros.id}"
    delete_on_termination = true
  }
}

# Create network port
resource "openstack_networking_port_v2" "port_vm6" {
  name           = "port-instance-vm6"
  network_id     = "${var.net1_id}"
  admin_state_up = true
  fixed_ip {
    subnet_id = "${var.subnet1_id}"
  }
}
