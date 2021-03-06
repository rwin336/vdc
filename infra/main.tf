# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "UXW45ZBMEzMK7Xxb"
  auth_url    = "https://10.86.200.232:5000/v3"
  cacert_file = "/var/vdc/certs/machv/haproxy-ca.crt"
  region      = "RegionOne"
}

module "flavors" {
   source = "./flavors"
}

module "images" {
   source = "./images"
}

module "project-vdc" {
   source = "./project-vdc"
}

module "project-marlin" {
   source = "./project-marlin"
}

#module "network" {
#   source = "./network"
#   vdc_project_id = "${module.project.vdc_project_id}"
#}
