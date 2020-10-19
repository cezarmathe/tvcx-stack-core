# consul-bootstrap

# Configure the Consul provider.
provider "consul" {
  address    = var.consul_address
  scheme     = "https"
  token      = var.consul_token
}

data "consul_agent_config" "remote" {}

### ACL POLICIES ###

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

resource "consul_acl_policy" "replication" {
  name = "replication"
  rules = file("${path.module}/policies/replication.hcl")
}

resource "consul_acl_policy" "vault" {
  name = "vault"
  rules = file("${path.module}/policies/vault.hcl")
}

### ROLES ###

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

### TOKENS ###

resource "consul_acl_token" "anonymous" {
  description = "Anonymous Token"
  policies    = ["${consul_acl_policy.dns.name}"]
}

resource "consul_acl_token" "vault_tvcxpi" {
  description = "Vault on tvcxpi"
  policies    = ["${consul_acl_policy.vault.name}"]
}

resource "consul_acl_token" "vault_tvcxvps" {
  description = "Vault on tvcxvps"
  policies    = ["${consul_acl_policy.vault.name}"]
}

resource "consul_acl_token" "vault_tvcxserver" {
  description = "Vault on tvcxserver"
  policies    = ["${consul_acl_policy.vault.name}"]
}

resource "consul_acl_token" "fabio_tvcxpi" {
  description = "Fabio on tvcxpi"
  policies    = ["${consul_acl_policy.fabio.name}"]
}

resource "consul_acl_token" "fabio_tvcxvps" {
  description = "Fabio on tvcxvps"
  policies    = ["${consul_acl_policy.fabio.name}"]
}

resource "consul_acl_token" "fabio_tvcxserver" {
  description = "Fabio on tvcxserver"
  policies    = ["${consul_acl_policy.fabio.name}"]
}

resource "consul_acl_token" "nomad_tvcxpi" {
  description = "Nomad on tvcxpi"
  policies    = ["${consul_acl_policy.nomad.name}"]
}

resource "consul_acl_token" "nomad_tvcxvps" {
  description = "Nomad on tvcxvps"
  policies    = ["${consul_acl_policy.nomad.name}"]
}

resource "consul_acl_token" "nomad_tvcxserver" {
  description = "Nomad on tvcxserver"
  policies    = ["${consul_acl_policy.nomad.name}"]
}

resource "consul_acl_token" "agent_tvcxpi" {
  description = "Consul agent on tvcxpi"
  policies    = ["${consul_acl_policy.agent_tvcxpi.name}"]
}

resource "consul_acl_token" "agent_tvcxvps" {
  description = "Consul agent on tvcxvps"
  policies    = ["${consul_acl_policy.agent_tvcxvps.name}"]
}

resource "consul_acl_token" "agent_tvcxserver" {
  description = "Consul agent on tvcxserver"
  policies    = ["${consul_acl_policy.agent_tvcxserver.name}"]
}

### KV ###
resource "consul_keys" "fabio_config" {
  key {
    path  = "fabio/config"
    value = "route add consul-ui consul.service.cons.ul:443 https://${var.consul_address}"
  }
}
