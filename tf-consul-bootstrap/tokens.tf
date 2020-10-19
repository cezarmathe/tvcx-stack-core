# tf-consul-bootstrap - tokens

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
