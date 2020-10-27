# consul-core-config

# Configure the Consul provider.
provider "consul" {
  address    = var.consul_address
  scheme     = "https"
  token      = var.consul_token
}

# Get a list of the nodes that need tokens. There should be 3 nodes.
data "consul_nodes" "all" {}

locals {
  # Sort the list of nodes by their name.
  all_nodes = sort(data.consul_nodes.all.node_names)
}

# policies - see policies.tf

resource "consul_acl_role" "operator" {
    name        = "operator"
    description = "Role for tokens to be used by operators."

    policies = [
      consul_acl_policy.dns.id,
      consul_acl_policy.acl_read.id,
      consul_acl_policy.operator_agent_control.id,
      consul_acl_policy.operator_catalog.id,
      consul_acl_policy.kv_write_tf.id,
      consul_acl_policy.kv_write_fabio.id
    ]
}

# tokens - see tokens.tf

resource "consul_keys" "fabio_config" {
  key {
    path  = "fabio/config"
    value = <<-VALUE
%{ for node in data.consul_nodes.all.nodes ~}
route add consul-ui-${node.name} consul.service.cons.ul:443 ${node.address}
%{ endfor ~}
    VALUE
  }
}
