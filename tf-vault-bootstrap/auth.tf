# vault-bootstrap - auth

# Create an admin user.
resource "vault_generic_endpoint" "admin_user" {
  depends_on           = ["vault_auth_backend.userpass"]
  path                 = "auth/userpass/users/${var.admin_user_name}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["admin", "consul_admin", "gv_admin", "nomad_admin", "pki_tvcx_admin"],
  "password": "${var.admin_user_password}"
}
EOT
}

# Create a new user for my personal usage.
resource "vault_generic_endpoint" "personal_user" {
  depends_on           = ["vault_auth_backend.userpass"]
  path                 = "auth/userpass/users/${var.personal_user_name}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["consul_user", "gv_user", "nomad_user"],
  "password": "${var.personal_user_password}"
}
EOT
}
