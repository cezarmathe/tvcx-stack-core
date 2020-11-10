# tf-consul-bootstrap - tokens

# This should be imported.
resource "consul_acl_token" "anonymous" {
  description = "Anonymous Token"
  policies    = [consul_acl_policy.dns.name]
}

# Token for agent0.
resource "consul_acl_token" "agent0" {
  description = "Consul agent on ${local.all_nodes[0]}"
  policies    = [consul_acl_policy.agent0.name]
}

# Token for agent1.
resource "consul_acl_token" "agent1" {
  description = "Consul agent on ${local.all_nodes[1]}"
  policies    = [consul_acl_policy.agent1.name]
}

# Token for agent2.
resource "consul_acl_token" "agent2" {
  description = "Consul agent on ${local.all_nodes[2]}"
  policies    = [consul_acl_policy.agent2.name]
}

# GM token for the Consul secrets engine.
resource "consul_acl_token" "secrets_engine" {
  description = "Consul secrets engine token for Vault"
  policies    = ["global-management"]
}

# Token for the Vault instance running on agent0.
resource "consul_acl_token" "vault0" {
  description = "Vault on ${local.all_nodes[0]}"
  policies    = [consul_acl_policy.vault.name]
}

# Token for the Vault instance running on agent1.
resource "consul_acl_token" "vault1" {
  description = "Vault on ${local.all_nodes[1]}"
  policies    = [consul_acl_policy.vault.name]
}

# Token for the Vault instance running on agent2.
resource "consul_acl_token" "vault2" {
  description = "Vault on ${local.all_nodes[2]}"
  policies    = [consul_acl_policy.vault.name]
}

# Token for the Nomad instance running on agent0.
resource "consul_acl_token" "nomad0" {
  description = "Nomad on ${local.all_nodes[0]}"
  policies    = [consul_acl_policy.nomad.name]
}

# Token for the Nomad instance running on agent1.
resource "consul_acl_token" "nomad1" {
  description = "Nomad on ${local.all_nodes[1]}"
  policies    = [consul_acl_policy.nomad.name]
}

# Token for the Nomad instance running on agent2.
resource "consul_acl_token" "nomad2" {
  description = "Nomad on ${local.all_nodes[2]}"
  policies    = [consul_acl_policy.nomad.name]
}

# Token for consul-template on host0.
resource "consul_acl_token" "ct_host0" {
  description = "consul-template on host0"
  policies    = [consul_acl_policy.kv_read_stack_config_nomad.name]
}

# Token for consul-template on host1.
resource "consul_acl_token" "ct_host1" {
  description = "consul-template on host1"
  policies    = [consul_acl_policy.kv_read_stack_config_nomad.name]
}

# Token for consul-template on host2.
resource "consul_acl_token" "ct_host2" {
  description = "consul-template on host2"
  policies    = [consul_acl_policy.kv_read_stack_config_nomad.name]
}
