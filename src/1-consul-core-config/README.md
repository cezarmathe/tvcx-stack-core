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
