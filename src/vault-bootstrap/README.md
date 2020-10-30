# vault-bootstrap

This module will bootstrap a Vault cluster by spinning up Docker containers running Vault on a
number of hosts.

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
    path         = "tf/state/vault-bootstrap"
    access_token = "my-token"
  }
}
```

## Example `main.auto.tfvars` file

```terraform
docker0_host = ""
docker1_host = ""
docker2_host = ""

vault_image_version = ""

host_ssl_volume_path  = "" # if you omit this, it will default to `/etc/vault.d/ssl`

vault0_consul_token         = ""
vault0_addr                 = ""
vault0_image_version        = "" # if you omit this, it will default to the value of `vault_image_version`
vault0_host_ssl_volume_path = "" # if you omit this, it will default to the value of `host_ssl_volume_path`

vault1_consul_token         = ""
vault1_addr                 = ""
vault1_image_version        = "" # if you omit this, it will default to the value of `vault_image_version`
vault1_host_ssl_volume_path = "" # if you omit this, it will default to the value of `host_ssl_volume_path`

vault2_consul_token         = ""
vault2_addr                 = ""
vault2_image_version        = "" # if you omit this, it will default to the value of `vault_image_version`
vault2_host_ssl_volume_path = "" # if you omit this, it will default to the value of `host_ssl_volume_path`
```
