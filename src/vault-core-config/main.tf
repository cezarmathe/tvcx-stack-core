# vault-core-config

terraform {
  required_providers {
    vault = "~> 2.15.0"
  }
}

# The Vault provider.
provider "vault" {
  address = "https://${var.vault_address}"
}

# auth - check auth.tf

# pki - check pki.tf

# consul - check consul.tf

# nomad - check nomad.tf

# policies - check policies.tf
