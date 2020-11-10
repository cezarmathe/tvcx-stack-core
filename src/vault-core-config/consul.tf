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

resource "vault_generic_endpoint" "consul_role_stack_state" {
  depends_on           = [vault_consul_secret_backend.consul]
  path                 = "consul/roles/stack_state"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["kv_write_stack_state"]
}
EOT
}

resource "vault_generic_endpoint" "consul_role_write_stack_config" {
  depends_on           = [vault_consul_secret_backend.consul]
  path                 = "consul/roles/write_stack_config"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["kv_write_stack_config"]
}
EOT
}

resource "vault_generic_endpoint" "consul_role_rw_stack" {
  depends_on           = [vault_consul_secret_backend.consul]
  path                 = "consul/roles/rw_stack"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["kv_write_stack_config", "kv_write_stack_state"]
}
EOT
}

resource "vault_generic_endpoint" "consul_role_read_stack_config_nomad" {
  depends_on           = [vault_consul_secret_backend.consul]
  path                 = "consul/roles/read_stack_config_nomad"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["kv_read_stack_config_nomad"]
}
EOT
}
