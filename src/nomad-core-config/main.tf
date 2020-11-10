# nomad-core-config

# Configure the Consul provider.
provider "consul" {
  address    = var.consul_address
  scheme     = "https"
  token      = var.consul_token
}

locals {
  nomad0_config = merge(local.common, local.nomad0)
  nomad1_config = merge(local.common, local.nomad1)
  nomad2_config = merge(local.common, local.nomad2)
}

resource "consul_keys" "nomad_config" {
  key {
    path  = "stack/config/nomad/nomad0"
    value = jsonencode(local.nomad0_config)
  }
  key {
    path  = "stack/config/nomad/nomad1"
    value = jsonencode(local.nomad1_config)
  }
  key {
    path  = "stack/config/nomad/nomad2"
    value = jsonencode(local.nomad2_config)
  }
}
