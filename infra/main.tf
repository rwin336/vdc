# Configure the OpenStack Provider
provider "openstack" {
  user_name   = ""
  tenant_name = ""
  password    = ""
  auth_url    = ""
  cacert_file = ""
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
