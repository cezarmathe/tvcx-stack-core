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
