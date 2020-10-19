# tf-consul-bootstrap - policies

resource "consul_acl_policy" "agent_tvcxpi" {
  name        = "agent-tvcxpi"
  rules       = <<-RULE
    node "tvcxpi" {
        policy = "write"
    }
  RULE
}

resource "consul_acl_policy" "agent_tvcxvps" {
  name        = "agent-tvcxvps"
  rules       = <<-RULE
    node "tvcxvps" {
        policy = "write"
    }
  RULE
}

resource "consul_acl_policy" "agent_tvcxserver" {
  name        = "agent-tvcxserver"
  rules       = <<-RULE
    node "tvcxserver" {
        policy = "write"
    }
  RULE
}

resource "consul_acl_policy" "dns" {
  name = "dns"
  rules = file("${path.module}/policies/dns.hcl")
}

resource "consul_acl_policy" "fabio" {
  name = "fabio"
  rules = file("${path.module}/policies/fabio.hcl")
}

resource "consul_acl_policy" "nomad" {
  name = "nomad"
  rules = file("${path.module}/policies/nomad.hcl")
}

resource "consul_acl_policy" "operator_acl_read" {
  name = "operator_acl_read"
  rules = file("${path.module}/policies/operator_acl_read.hcl")
}

resource "consul_acl_policy" "operator_acl_write" {
  name = "operator_acl_write"
  rules = file("${path.module}/policies/operator_acl_write.hcl")
}

resource "consul_acl_policy" "operator_agent_control" {
  name = "operator_agent_control"
  rules = file("${path.module}/policies/operator_agent_control.hcl")
}

resource "consul_acl_policy" "operator_catalog" {
  name = "operator_catalog"
  rules = file("${path.module}/policies/operator_catalog.hcl")
}

resource "consul_acl_policy" "operator_kv_read" {
  name = "operator_kv_read"
  rules = file("${path.module}/policies/operator_kv_read.hcl")
}

resource "consul_acl_policy" "operator_kv_write" {
  name = "operator_kv_write"
  rules = file("${path.module}/policies/operator_kv_write.hcl")
}

resource "consul_acl_policy" "operator_kv_write_fabio" {
  name = "operator_kv_write_fabio"
  rules       = <<-RULE
    # Policy for creating tokens for operators that need to write to the fabio configuration in the KV.

    key_prefix "fabio" {
        policy = "write"
    }
  RULE
}

resource "consul_acl_policy" "vault" {
  name = "vault"
  rules = file("${path.module}/policies/vault.hcl")
}
