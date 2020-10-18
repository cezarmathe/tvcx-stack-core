# consul-bootstrap variables

variable "consul_address" {
  type = string
  description = "The address of the Consul agent."
}

variable "consul_token" {
  type = string
  description = "The Consul token required by the Consul provider."
}
