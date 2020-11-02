# vault-core-config - pki

locals {
  stack_allowed_domains = [
    "localhost",
    "127.0.0.1",
    "*.node.${var.consul_domain}"
  ]
}

# Enable the PKI secrets engine for TVCX.
resource "vault_mount" "pki" {
  path        = "pki"
  type        = "pki"
  description = "PKI secrets backend."

  default_lease_ttl_seconds = 604800   # One week
  max_lease_ttl_seconds     = 2419200  # Four weeks
}

### Configure the PKI secrets engine ###

# The PEM bundle must be installed manually!
#resource "vault_pki_secret_backend_config_ca" "intermediate" {
#  depends_on = [vault_mount.pki]
#
#  backend    = vault_mount.pki.path
#  pem_bundle = file("${path.module}/bundle.pem")
#}

resource "vault_pki_secret_backend_config_urls" "config_urls" {
  backend                 = vault_mount.pki.path
  issuing_certificates    = ["https://${var.vault_address}/v1/${vault_mount.pki.path}/ca"]
  crl_distribution_points = ["https://${var.vault_address}/v1/${vault_mount.pki.path}/crl"]
}

# Role for issuing certificates for consul.
resource "vault_pki_secret_backend_role" "role_stack" {
  backend            = vault_mount.pki.path
  name               = "stack"
  allowed_domains    = local.stack_allowed_domains
  allow_bare_domains = true
  allow_subdomains   = true
}

resource "vault_pki_secret_backend_role" "role_proxy" {
  backend            = vault_mount.pki.path
  name               = "proxy"
  allowed_domains    = [var.consul_domain]
  allow_bare_domains = false
  allow_subdomains   = true
}
