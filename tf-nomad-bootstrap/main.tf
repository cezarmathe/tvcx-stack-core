# tf-nomad-bootstrap

# Configure the Nomad provider
provider "nomad" {
  address   = var.nomad_address
  secret_id = var.nomad_token
}

resource "nomad_acl_policy" "dev" {
  name        = "dev"
  description = "Submit jobs."
  rules_hcl   = file("${path.module}/policies/dev.hcl")
}

resource "nomad_acl_policy" "op" {
  name        = "op"
  description = "Operator"
  rules_hcl   = file("${path.module}/policies/op.hcl")
}
