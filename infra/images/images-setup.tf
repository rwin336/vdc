
resource "openstack_images_image_v2" "cirros" {
  name   = "Cirros"
  image_source_url = "http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img"
  container_format = "bare"
  disk_format = "qcow2"
  visibility = "public"
}

resource "openstack_images_image_v2" "centos6" {
  name   = "CentOS6"
  image_source_url = "http://cloud.centos.org/centos/6/images/CentOS-6-x86_64-GenericCloud.qcow2"
  container_format = "bare"
  disk_format = "qcow2"
  visibility = "public"
}

resource "openstack_images_image_v2" "centos7" {
  name   = "CentOS7"
  image_source_url = "http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  container_format = "bare"
  disk_format = "qcow2"
  visibility = "public"
}

resource "openstack_images_image_v2" "xenial" {
  name   = "Xenial16"
  image_source_url = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img"
  container_format = "bare"
  disk_format = "qcow2"
  visibility = "public"
}

#resource "openstack_images_image_v2" "bionic" {
#  name   = "Xenial16"
#  image_source_url = "http://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
#  container_format = "bare"
#  disk_format = "qcow2"
#  visibility = "public"
#}
