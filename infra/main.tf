# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "ryEa6RVZDCpOdZmj"
  auth_url    = "https://10.86.200.232:5000/v3"
  cacert_file = "/var/vdc/certs/haproxy-ca.crt"
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
