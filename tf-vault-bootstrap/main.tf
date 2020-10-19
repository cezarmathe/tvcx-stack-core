# vault-bootstrap

# The Vault provider.
provider "vault" {}

# Enable the userpass auth method.
resource "vault_auth_backend" "userpass" {
  type = "userpass"

  tune {
    max_lease_ttl      = "90000s"
    listing_visibility = "unauth"
  }
}

# Enable the file audit.
resource "vault_audit" "file_audit" {
  type = "file"

  options = {
    file_path = "/vault/logs/audit.txt"
  }
}

# Enable the KV2 secrets engine on secret/git for gv.
resource "vault_mount" "kv2_git" {
  path        = "secret/git"
  type        = "kv-v2"
  description = "KV storage for gv."
}

# Enable the PKI secrets engine for TVCX.
resource "vault_mount" "pki" {
  path        = "pki_tvcx"
  type        = "pki"
  description = "PKI secrets backend for TVCX."

  default_lease_ttl_seconds = 604800   # One week
  max_lease_ttl_seconds     = 2419200  # Four weeks
}

# Enable the Consul secrets engine.
resource "vault_consul_secret_backend" "consul" {
  path        = "consul"
  description = "Consul secrets engine."

  address = "127.0.0.1:8500"
  scheme  = "https"
  token   = var.consul_token

  default_lease_ttl_seconds = 14400 # Four hours
  max_lease_ttl_seconds     = 86400 # One day
}

# Enable the Nomad secrets engine.
resource "vault_mount" "nomad" {
  path        = "nomad"
  type        = "nomad"
  description = "Nomad secrets engine."

  default_lease_ttl_seconds = 14400 # Four hours
  max_lease_ttl_seconds     = 86400 # One day

  options = {
    address = "https://127.0.0.1:4646"
    token   = var.nomad_token
  }
}

# A token for fabio
resource "vault_token" "fabio" {
  policies = ["pki_tvcx_issue"]

  renewable = true
  ttl       = "24h"

  renew_min_lease = 43200
  renew_increment = 86400
}
