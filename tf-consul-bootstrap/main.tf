# consul-bootstrap

# Configure the Consul provider.
provider "consul" {
  address    = var.consul_address
  scheme     = "https"
  token      = var.consul_token
}

data "consul_agent_config" "remote" {}

# policies - see policies.tf

resource "consul_acl_role" "operator" {
    name        = "operator"
    description = "Role for tokens to be used by operators."

    policies = [
      "${consul_acl_policy.dns.id}",
      "${consul_acl_policy.operator_acl_read.id}",
      "${consul_acl_policy.operator_agent_control.id}",
      "${consul_acl_policy.operator_kv_write_fabio.id}"
    ]
}

# tokens - see tokens.tf

resource "consul_keys" "fabio_config" {
  key {
    path  = "fabio/config"
    value = "route add consul-ui consul.service.cons.ul:443 https://${var.consul_address}"
  }
}
