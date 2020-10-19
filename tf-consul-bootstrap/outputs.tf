# consul-bootstrap outputs

output "consul_vault_tvcxpi_token" {
  value = consul_acl_token.vault_tvcxpi
}

output "consul_vault_tvcxvps_token" {
  value = consul_acl_token.vault_tvcxvps
}

output "consul_vault_tvcxdorm_token" {
  value = consul_acl_token.vault_tvcxdorm
}

output "consul_nomad_tvcxpi_token" {
  value = consul_acl_token.nomad_tvcxpi
}

output "consul_nomad_tvcxvps_token" {
  value = consul_acl_token.nomad_tvcxvps
}

output "consul_nomad_tvcxdorm_token" {
  value = consul_acl_token.nomad_tvcxdorm
}

output "consul_fabio_tvcxpi_token" {
  value = consul_acl_token.fabio_tvcxpi
}

output "consul_fabio_tvcxvps_token" {
  value = consul_acl_token.fabio_tvcxvps
}

output "consul_fabio_tvcxdorm_token" {
  value = consul_acl_token.fabio_tvcxdorm
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
