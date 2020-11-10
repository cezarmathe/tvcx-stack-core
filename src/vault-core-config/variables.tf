# vault-core-config - variables

variable "admin_user_name" {
  type        = string
  description = "The user name of the admin account to be created."
}

variable "admin_user_password" {
  type        = string
  description = "The password of the admin account to be created."
}

variable "admin_policies" {
  type        = list(string)
  description = "A list of policies to be given to the admin account."
  default     = []
}

variable "consul_address" {
  type        = string
  description = "Address to be used by the Consul secrets engine."
}

variable "consul_token" {
  type        = string
  description = "Token to be used by the Consul secrets engine."
}

variable "consul_domain" {
  type        = string
  description = "The domain name used for Consul DNS queries."
}

variable "consul_policies" {
  type        = list(string)
  description = "A list of policies to be added to consul tokens from the Consul secrets engine."
  default     = []
}

variable "nomad_address" {
  type        = string
  description = "Address to be used by the Nomad secrets engine."
}

variable "nomad_token" {
  type        = string
  description = "Token to be used by the Nomad secrets engine."
}

variable "nomad_role_allowed_policies" {
  type        = list(string)
  description = "A list of policies to be allowed for the nomad role."
  default     = []
}

variable "personal_user_name" {
  type        = string
  description = "The user name of the personal account to be created."
}

variable "personal_user_password" {
  type        = string
  description = "The password of the personal account to be created."
}

variable "personal_user_policies" {
  type        = list(string)
  description = "A list of policies to be given to the personal account."
  default     = []
}

variable "pki_stack_addresses" {
  type        = list(string)
  description = "A list of addresses that the stack certificates are allowed."
  default     = []
}

variable "vault_address" {
  type        = string
  description = "The address of Vault."
}
