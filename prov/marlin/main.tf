# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "rwin4570"
  tenant_name = "marlin"
  password    = "cisco123"
  auth_url    = "https://10.86.200.232:5000/v3"
  cacert_file = "/var/vdc/certs/machv/haproxy-ca.crt"
}

module "variables" {
   source = "./vars"
}

module "network" {
   source = "./network"
}

module "servers" {
   source = "./servers"
   net1_id = "${module.network.net1_id}"
   subnet1_id = "${module.network.subnet1_id}"
   net2_id = "${module.network.net2_id}"
   subnet2_id = "${module.network.subnet2_id}"
}

