# tf-nomad-bootstrap - variables

variable "nomad_address" {
  type = string
  description = "The address of the Nomad server."
}

variable "nomad_token" {
  type = string
  description = "ACL token to use for interacting with the Nomad provider."
}
