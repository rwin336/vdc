# Configure the OpenStack Provider

resource "openstack_identity_project_v3" "marlin" {
  name = "marlin"
}

resource "openstack_identity_user_v3" "rwin4570" {
  default_project_id = "${openstack_identity_project_v3.marlin.id}"
  name = "rwin4570"
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
    email = "rwin4570@gmail.com"
  }
}

data "openstack_identity_role_v3" "admin" {
  name = "admin"
}

resource "openstack_identity_role_assignment_v3" "role_assignment_2" {
  user_id = "${openstack_identity_user_v3.rwin4570.id}"
  project_id = "${openstack_identity_project_v3.marlin.id}"
  role_id = "${data.openstack_identity_role_v3.admin.id}"
}

output "marlin_project_id" { value = "${openstack_identity_project_v3.marlin.id}"}