# vault-core-config - auth

locals {
  # List of policies available to the admin user.
  admin_policies = jsonencode(var.admin_policies)
  # List of policies available to the personal user.
  user_policies  = jsonencode(var.personal_user_policies)
}

# Enable the userpass auth method.
resource "vault_auth_backend" "userpass" {
  type = "userpass"

  tune {
    listing_visibility = "unauth"
  }
}

# Create an admin user.
resource "vault_generic_endpoint" "admin_user" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/${var.admin_user_name}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ${local.admin_policies},
  "password": "${var.admin_user_password}"
}
EOT
}

# Create a new user for my personal usage.
resource "vault_generic_endpoint" "personal_user" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/${var.personal_user_name}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ${local.user_policies},
  "password": "${var.personal_user_password}"
}
EOT
}
