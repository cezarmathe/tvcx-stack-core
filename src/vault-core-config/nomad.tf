# vault-core-config - nomad

locals {
  # A list of allowed policies for the nomad role.
  nomad_role_allowed_policies = jsonencode(var.nomad_role_allowed_policies)
}

# Enable the Nomad secrets engine.
resource "vault_mount" "nomad" {
  path        = "nomad"
  type        = "nomad"
  description = "Nomad secrets engine."

  default_lease_ttl_seconds = 14400 # Four hours
  max_lease_ttl_seconds     = 86400 # One day

  options = {
    address = "https://${var.nomad_address}"
    token   = var.nomad_token
  }
}

### Configure the Nomad secrets engine ###

# Developer role
resource "vault_generic_endpoint" "nomad_role_dev" {
  depends_on           = [vault_mount.nomad]
  path                 = "nomad/role/dev"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": "dev"
}
EOT
}

# Operator role
resource "vault_generic_endpoint" "nomad_role_op" {
  depends_on           = [vault_mount.nomad]
  path                 = "nomad/role/op"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": "op"
}
EOT
}

### Configure Nomad-Vault integration

resource "vault_generic_endpoint" "nomad_tokens_role" {
  depends_on           = [vault_policy.nomad_server]
  path                 = "auth/token/roles/nomad-role"
  ignore_absent_fields = true
  disable_read         = true

  data_json = templatefile("${path.module}/roles/nomad.json", {
    allowed_policies = local.nomad_role_allowed_policies
  })
}
