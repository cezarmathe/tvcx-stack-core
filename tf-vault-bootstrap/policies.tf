# vault-bootstrap - policies

# Create an admin policy.
resource "vault_policy" "admin" {
  name = "admin"

  policy = file("${path.module}/../../vault/policies_template/admin.hcl")
}

# Create a consul admin policy.
resource "vault_policy" "consul_admin" {
  name = "consul_admin"

  policy = file("${path.module}/../../vault/policies_template/consul_admin.hcl")
}

# Create a consul user policy.
resource "vault_policy" "consul_user" {
  name = "consul_user"

  policy = file("${path.module}/../../vault/policies_template/consul_user.hcl")
}

# Create a gv admin policy.
resource "vault_policy" "gv_admin" {
  name = "gv_admin"

  policy = file("${path.module}/../../vault/policies_template/gv_admin.hcl")
}

# Create a gv user policy.
resource "vault_policy" "gv_user" {
  name = "gv_user"

  policy = file("${path.module}/../../vault/policies_template/gv_user.hcl")
}

# Create a nomad admin policy.
resource "vault_policy" "nomad_admin" {
  name = "nomad_admin"

  policy = file("${path.module}/../../vault/policies_template/nomad_admin.hcl")
}

# Create a nomad user policy.
resource "vault_policy" "nomad_user" {
  name = "nomad_user"

  policy = file("${path.module}/../../vault/policies_template/nomad_user.hcl")
}

# Create an admin policy for the tvcx pki.
resource "vault_policy" "pki_tvcx_admin" {
  name = "pki_tvcx_admin"

  policy = file("${path.module}/../../vault/policies_template/pki_tvcx_admin.hcl")
}

# Create a policy for issuing certificates from the tvcx pki.
resource "vault_policy" "pki_tvcx_issue" {
  name = "pki_tvcx_issue"

  policy = templatefile("${path.module}/../../vault/policies_template/pki_tvcx_issue.hcl", {
    role = var.policy_pki_tvcx_issue_role # you should source the role name from the pki configuration
  })
}
