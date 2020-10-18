# tvcx-stack-core - variables

variable "consul_image_version" {
  type = string
  description = "Version of the Consul docker image."
}

variable "coredns_image_version" {
  type = string
  description = "Version of the CoreDNS docker image."
}

variable "vault_image_version" {
  type = string
  description = "Version of the Vault docker image."
}

variable "fabio_image_id" {
  type = string
  description = "The ID of the Fabio docker image."
}
