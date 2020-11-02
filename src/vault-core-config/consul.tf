# vault-core-config - consul

locals {
  consul_policies = jsonencode(var.consul_policies)
}

# Enable the Consul secrets engine.
resource "vault_consul_secret_backend" "consul" {
  path        = "consul"
  description = "Consul secrets engine."

  address = var.consul_address
  scheme  = "https"
  token   = var.consul_token

  default_lease_ttl_seconds = 14400 # Four hours
  max_lease_ttl_seconds     = 86400 # One day
}

### Configure the Consul secrets engine ###

resource "vault_generic_endpoint" "consul_role_operator" {
  depends_on           = [vault_consul_secret_backend.consul]
  path                 = "consul/roles/operator"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ${local.consul_policies}
}
EOT
}
