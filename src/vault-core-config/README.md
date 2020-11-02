# vault-core-config

This module will create the core configuration for the Vault cluster.

## Usage

1. Create a file named `backend_override.tf` and fill it with the backend configuration(you can
find an example below).
2. Create a file named `main.auto.tfvars` and fill it with the required variables.
3. Run `terraform apply`.

## Backend configuration

This is an example backend configuration.

```terraform
terraform {
  backend "consul" {
    address      = "consul.addre.ss"
    scheme       = "https"
    path         = "tf/state/vault-core-config"
    access_token = "my-token"
  }
}
```

## Authentication

This module will enable the `userpass` auth backend and will create two users: one for regular
usage and one for admin purposes.

## Secrets engines

This module will enable and configure the following secrets engines:

- [consul](https://www.vaultproject.io/docs/secrets/consul) - for dynamic Consul operator tokens
- [nomad](https://www.vaultproject.io/docs/secrets/nomad) - for dynamic nomad developer and operator tokens
- [pki](https://www.vaultproject.io/docs/secrets/pki) - for the certificate authority used by the stack and proxy

## Policies

This module will add the following policies:

- [admin](policies/admin.hcl)
- [consul_admin](policies/consul_admin.hcl)
- [consul_user](policies/consul_user.hcl)
- [nomad_admin](policies/nomad_admin.hcl)
- [nomad_server](policies/nomad_server.hcl)
- [nomad_user](policies/nomad_user.hcl)
- [pki_admin](policies/pki_admin.hcl)
- [pki_issue](policies/pki_issue.hcl)

## Roles

This module will add a role for nomad to use for retrieving dynamic secrets for its jobs.

## Example `main.auto.tfvars` file

```terraform
admin_user_name     = ""
admin_user_password = ""
admin_policies      = []

consul_address = ""
consul_token   = ""
consul_domain  = ""
consul_policies = []

nomad_address               = "
nomad_token                 = ""
nomad_role_allowed_policies = []

personal_user_name     = ""
personal_user_password = ""
personal_user_policies = []

pki_stack_addresses = []

vault_address = ""
```
