# nomad-core-config

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
    path         = "stack/state/nomad-core-config"
    access_token = "my-token"
  }
}
```

## Example `main.auto.tfvars` file

```terraform
consul_address = ""
# this is for the consul provider where the configuration will be stored
# individual consul tokens for each nomad server are required later
consul_token   = ""

datacenter         = ""
servers_retry_join = [
    "",
    "",
    ""
]
data_dir = "" # if you omit this field, it will default to `/var/lib/nomad`
ssl_dir  = "" # # if you omit this field, it will default to `/etc/nomad.d/ssl`

lan_reserved_ports = "" # if you omit this field, it will default to `22,51820`
wg_reserved_ports  = "" # if you omit this field, it will default to `22`

nomad0_data_dir           = "" # if you omit this field, it will default to `data_dir`
nomad0_ssl_dir            = "" # if you omit this field, it will default to `ssl_dir`
nomad0_consul_token       = ""
nomad0_vault_token        = ""
nomad0_lan_name           = "" # if you omit this field, it will default to `nomad0_lan`
nomad0_lan_cidr           = ""
nomad0_lan_reserved_ports = "" # if you omit this field, it will default to `lan_reserved_ports`
nomad0_wg_name            = "" # if you omit this field, it will default to `nomad0_wg`
nomad0_wg_cidr            = ""
nomad0_wg_reserved_ports  = "" # if you omit this field, it will default to `wg_reserved_ports`

nomad1_data_dir           = "" # if you omit this field, it will default to `data_dir`
nomad1_ssl_dir            = "" # if you omit this field, it will default to `ssl_dir`
nomad1_consul_token       = ""
nomad1_vault_token        = ""
nomad1_lan_name           = "" # if you omit this field, it will default to `nomad1_lan`
nomad1_lan_cidr           = ""
nomad1_lan_reserved_ports = "" # if you omit this field, it will default to `lan_reserved_ports`
nomad1_wg_name            = "" # if you omit this field, it will default to `nomad1_wg`
nomad1_wg_cidr            = ""
nomad1_wg_reserved_ports  = "" # if you omit this field, it will default to `wg_reserved_ports`

nomad2_data_dir           = "" # if you omit this field, it will default to `data_dir`
nomad2_ssl_dir            = "" # if you omit this field, it will default to `ssl_dir`
nomad2_consul_token       = ""
nomad2_vault_token        = ""
nomad2_lan_name           = "" # if you omit this field, it will default to `nomad2_lan`
nomad2_lan_cidr           = ""
nomad2_lan_reserved_ports = "" # if you omit this field, it will default to `lan_reserved_ports`
nomad2_wg_name            = "" # if you omit this field, it will default to `nomad2_wg`
nomad2_wg_cidr            = ""
nomad2_wg_reserved_ports  = "" # if you omit this field, it will default to `wg_reserved_ports`
```
