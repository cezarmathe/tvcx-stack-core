# consul-bootstrap

This module will bootstrap a Consul cluster by spinning up Docker containers running Consul on a
number of hosts.

Initially, this module will store its state locally, but it can be later migrated to be self-hosted
on the cluster itself.

## Usage

1. Create a file named `main.auto.tfvars` and fill it with the required variables.
2. Run `terraform apply`.
3. Run `CONSUL_HTTP_ADDR="https://your-consul-address:8500" CONSUL_TOKEN="your-token-here" consul acl bootstrap`
4. (Optional) Migrate your Terraform state to Consul.

## Terraform backend

Initially, you won't have any Consul cluster for remote storage for the Terraform state. That means
the state will have to be stored locally. After initialising the cluster and bootstrapping the ACL
system, though, you should create a `backend_override.tf` file with the following contents:

```terraform
# consul-bootstrap - backend

terraform {
  backend "consul" {
    address      = "<the address of your consul cluster>"
    scheme       = "https"
    path         = "tf/state/consul-bootstrap"
    access_token = "your-token
  }
}
```

This will override the local storage backend with the remote one, letting you migrate the Terraform
state.

## Rolling upgrades/modifications

For the purpose of not killing off your Consul cluster, there are some default variables such as
`consul_image_version`, `host_data_volume_path` etc that can be customized for each agent. This
is intentional. You can fine-tune those variables to upgrade/modify your agents one by one, keeping
your Consul cluster intact.

## Starter main.auto.tfvars file

This is a starter `main.auto.tfvars` file:

```terraform
# variables

docker0_host = ""
docker1_host = ""
docker2_host = ""

consul_image_version = ""

host_data_volume_path = "" # if you ommit this field, it will default to `/var/consul`
host_ssl_volume_path  = "" # if you ommit this field, it will default to `/etc/consul.d/ssl`

datacenter         = ""
domain             = "" # if you ommit this field, it will default to `consul`
primary_datacenter = "" # if you ommit this field, the primary datacenter will default to the value of `datacenter`
retry_join         = [
    "", # consul0 bind address
    "", # consul1 bind address
    ""  # consul2 bind address
]
log_level = "" # if you ommit this field, it will default to `warn`

consul0_acl_tokens_agent      = "" # if you ommit this field, it will default to the value of ``(empty string)
consul0_bind_cidr             = ""
consul0_image_version         = "" # if you ommit this field, it will default to the value of `consul_image_version`
consul0_host_data_volume_path = "" # if you ommit this field, it will default to the value of `host_data_volume_path`
consul0_host_ssl_volume_path  = "" # if you ommit this field, it will default to the value of `host_ssl_volume_path`

consul1_acl_tokens_agent      = "" # if you ommit this field, it will default to the value of ``(empty string)
consul1_bind_cidr             = ""
consul1_image_version         = "" # if you ommit this field, it will default to the value of `consul_image_version`
consul1_host_data_volume_path = "" # if you ommit this field, it will default to the value of `host_data_volume_path`
consul1_host_ssl_volume_path  = "" # if you ommit this field, it will default to the value of `host_ssl_volume_path`

consul2_acl_tokens_agent      = "" # if you ommit this field, it will default to the value of ``(empty string)
consul2_bind_cidr             = ""
consul2_image_version         = "" # if you ommit this field, it will default to the value of `consul_image_version`
consul2_host_data_volume_path = "" # if you ommit this field, it will default to the value of `host_data_volume_path`
consul2_host_ssl_volume_path  = "" # if you ommit this field, it will default to the value of `host_ssl_volume_path`
```
