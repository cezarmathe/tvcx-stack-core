# consul-core-config - policies

# Policy for the agent running on the first node.
resource "consul_acl_policy" "agent0" {
  name  = "agent-${local.all_nodes[0]}"
  rules = templatefile("${path.module}/policies/agent.hcl", {
    agent = local.all_nodes[0]
  })
}

# Policy for the agent running on the second node.
resource "consul_acl_policy" "agent1" {
  name  = "agent-${local.all_nodes[1]}"
  rules = templatefile("${path.module}/policies/agent.hcl", {
    agent = local.all_nodes[1]
  })
}

# Policy for the agent running on the third node.
resource "consul_acl_policy" "agent2" {
  name  = "agent-${local.all_nodes[2]}"
  rules = templatefile("${path.module}/policies/agent.hcl", {
    agent = local.all_nodes[2]
  })
}

# Policy made for the anonymous token for allowing DNS queries.
resource "consul_acl_policy" "dns" {
  name  = "dns"
  rules = file("${path.module}/policies/dns.hcl")
}

# Policy for fabio, a TCP/HTTP(s) proxy.
resource "consul_acl_policy" "fabio" {
  name  = "fabio"
  rules = file("${path.module}/policies/fabio.hcl")
}

# Policy for nomad.
resource "consul_acl_policy" "nomad" {
  name  = "nomad"
  rules = file("${path.module}/policies/nomad.hcl")
}

resource "consul_acl_policy" "acl_read" {
  name  = "acl_read"
  rules = file("${path.module}/policies/acl_read.hcl")
}

resource "consul_acl_policy" "acl_write" {
  name  = "acl_write"
  rules = file("${path.module}/policies/acl_write.hcl")
}

resource "consul_acl_policy" "operator_agent_control" {
  name  = "operator_agent_control"
  rules = file("${path.module}/policies/operator_agent_control.hcl")
}

resource "consul_acl_policy" "operator_catalog" {
  name  = "operator_catalog"
  rules = file("${path.module}/policies/operator_catalog.hcl")
}

resource "consul_acl_policy" "kv_write_tf" {
  name  = "kv_write_tf"
  rules = templatefile("${path.module}/policies/kv_write.hcl", {
    prefix = "tf/"
  })
}

resource "consul_acl_policy" "kv_write_fabio" {
  name  = "kv_write_fabio"
  rules = templatefile("${path.module}/policies/kv_write.hcl", {
    prefix = "fabio/"
  })
}

# Policy for Vault.
resource "consul_acl_policy" "vault" {
  name = "vault"
  rules = file("${path.module}/policies/vault.hcl")
}

# Add policies for the consul-template agents for accessing config/stack-core/
