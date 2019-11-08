# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "Olj7HpKSZLeW8pd3"
  auth_url    = "https://172.29.86.27:5000/v3"
  cacert_file = "/var/vdc/certs/skull/haproxy-ca.crt"
  region      = "RegionOne"
}

module "flavors" {
   source = "./flavors"
}

module "images" {
   source = "./images"
}

module "project" {
   source = "./project"
}

module "network" {
   source = "./network"
   vdc_project_id = "${module.project.vdc_project_id}"
}