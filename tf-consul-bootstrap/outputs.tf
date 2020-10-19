# consul-bootstrap outputs

output "consul_vault_token" {
  value = consul_acl_token.vault
}

output "consul_nomad_token" {
  value = consul_acl_token.nomad
}

output "consul_fabio_token" {
  value = consul_acl_token.fabio
}

output "consul_agent_tvcxpi_token" {
  value = consul_acl_token.agent_tvcxpi
}

output "consul_agent_tvcxvps_token" {
  value = consul_acl_token.agent_tvcxvps
}

output "consul_agent_tvcxdorm_token" {
  value = consul_acl_token.agent_tvcxdorm
}
