# Configure the OpenStack Provider

resource "openstack_identity_project_v3" "vdc" {
  name = "vdc"
}

resource "openstack_identity_user_v3" "rwin336" {
  default_project_id = "${openstack_identity_project_v3.vdc.id}"
  name = "rwin336"
  description = "A user"

  password = "cisco123"

  ignore_change_password_upon_first_use = true

  multi_factor_auth_enabled = true

  multi_factor_auth_rule {
    rule = ["password", "totp"]
  }

  multi_factor_auth_rule {
    rule = ["password"]
  }

  extra {
    email = "rwin336@gmail.com"
  }
}

data "openstack_identity_role_v3" "admin" {
  name = "admin"
}

resource "openstack_identity_role_assignment_v3" "role_assignment_2" {
  user_id = "${openstack_identity_user_v3.rwin336.id}"
  project_id = "${openstack_identity_project_v3.vdc.id}"
  role_id = "${data.openstack_identity_role_v3.admin.id}"
}

output "vdc_project_id" { value = "${openstack_identity_project_v3.vdc.id}"}