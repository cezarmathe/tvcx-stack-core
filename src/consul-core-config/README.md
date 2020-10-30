# consul-core-config

This module creates the core configuration of the Consul cluster.

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
    path         = "tf/state/consul-core-config"
    access_token = "my-token"
  }
}
```

## Policies

- [agent policies](policies/agent.hcl) for each node in the cluster
- [dns](policies/dns.hcl)
- [fabio](policies/fabio.hcl)
- [nomad](policies/nomad.hcl)
- [vault](policies/vault.hcl)
- [read acl](policies/acl_read.hcl)
- [write acl](policies/acl_write.hcl)
- [operator agent control](policies/operator_agent_control.hcl)
- [operator catalog](policies/operator_catalog.hcl)
- [kw write](policies/kv_write.hcl) for these prefixes: `tf/`, `fabio/`

## Roles

- operator role with the following policies:
  - `dns`
  - `acl_read`
  - `operator_agent_control`
  - `operator_catalog`
  - `kv_write_tf`
  - `kv_write_fabio`

## Tokens

- tokens for each node in the cluster
- updated anonymous token that has the `dns` policy
- tokens for each vault node in the cluster
- tokens for each nomad node in the cluster
- global management token to be used by vault in the consul secrets engine

## KV

- `fabio/config` key that adds custom routes to each consul agent ui

## Example `main.auto.tfvars` file

```terraform
consul_address = ""
consul_token   = ""
```
