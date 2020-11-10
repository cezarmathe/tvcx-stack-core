# vault-core-config - policies

# Create an admin policy.
resource "vault_policy" "admin" {
  name   = "admin"
  policy = file("${path.module}/policies/admin.hcl")
}

# Create a consul admin policy.
resource "vault_policy" "consul_admin" {
  name   = "consul_admin"
  policy = file("${path.module}/policies/consul_admin.hcl")
}

# Create a consul user policy.
resource "vault_policy" "consul_user" {
  name   = "consul_user"
  policy = file("${path.module}/policies/consul_user.hcl")
}

# Create a nomad admin policy.
resource "vault_policy" "nomad_admin" {
  name   = "nomad_admin"
  policy = file("${path.module}/policies/nomad_admin.hcl")
}

# Create a nomad user policy.
resource "vault_policy" "nomad_user" {
  name   = "nomad_user"
  policy = file("${path.module}/policies/nomad_user.hcl")
}

# Create an admin policy for the pki secrets engine.
resource "vault_policy" "pki_admin" {
  name   = "pki_admin"
  policy = file("${path.module}/policies/pki_admin.hcl")
}

# Create a policy for issuing certificates for stack components from the pki secrets engine.
resource "vault_policy" "pki_issue_stack" {
  name   = "pki_issue_stack"
  policy = templatefile("${path.module}/policies/pki_issue.hcl", {
    role = "stack"
  })
}

# Create a policy for issuing certificates for the reverse proxy from the pki secrets engine.
resource "vault_policy" "pki_issue_proxy" {
  name   = "pki_issue_proxy"
  policy = templatefile("${path.module}/policies/pki_issue.hcl", {
    role = "proxy"
  })
}

# Create a policy for the Nomad server tokens.
resource "vault_policy" "nomad_server" {
  name   = "nomad_server"
  policy = templatefile("${path.module}/policies/nomad_server.hcl", {
    role = "nomad-role"
  })
}
