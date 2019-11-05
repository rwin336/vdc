
resource "openstack_compute_flavor_v2" "extra_tiny" {
  name  = "m1.extra_tiny"
  ram   = "256"
  vcpus = "1"
  disk  = "0"
  is_public = "True"
  rx_tx_factor = "1"
}

resource "openstack_compute_flavor_v2" "tiny" {
  name  = "m1.tiny"
  ram   = "512"
  vcpus = "1"
  disk  = "1"
  is_public = "True"
  rx_tx_factor = "1"
}

resource "openstack_compute_flavor_v2" "small" {
  name  = "m1.small"
  ram   = "2048"
  vcpus = "1"
  disk  = "20"
  is_public = "True"
  rx_tx_factor = "1"
}

resource "openstack_compute_flavor_v2" "medium" {
  name  = "m1.medium"
  ram   = "4096"
  vcpus = "2"
  disk  = "40"
  is_public = "True"
  rx_tx_factor = "1"
}

resource "openstack_compute_flavor_v2" "large" {
  name  = "m1.large"
  ram   = "8192"
  vcpus = "4"
  disk  = "80"
  is_public = "True"
  rx_tx_factor = "1"
}

resource "openstack_compute_flavor_v2" "xlarge" {
  name  = "m1.xlarge"
  ram   = "16384"
  vcpus = "8"
  disk  = "160"
  is_public = "True"
  rx_tx_factor = "1"
}
