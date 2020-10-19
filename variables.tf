# tvcx-stack-core - variables

variable "consul_image_version" {
  type = string
  description = "Version of the Consul docker image."
}

variable "coredns_image_version" {
  type = string
  description = "Version of the CoreDNS docker image."
}

variable "fabio_image_version" {
  type = string
  description = "Version of the Fabio docker image."
}

variable "vault_image_version" {
  type = string
  description = "Version of the Vault docker image."
}

variable "vault_addr" {
  type = string
  description = "Address to Vault"
}
