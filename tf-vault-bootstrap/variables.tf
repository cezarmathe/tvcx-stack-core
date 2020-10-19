# consul-bootstrap - variables

variable "consul_token" {
  type        = string
  description = "Token to be used by the Consul secrets engine."
}

variable "nomad_token" {
  type        = string
  description = "Token to be used by the Nomad secrets engine."
}

variable "admin_user_name" {
  type        = string
  description = "The user name of the admin account to be created."
}

variable "admin_user_password" {
  type        = string
  description = "The password of the admin account to be created."
}

variable "personal_user_name" {
  type        = string
  description = "The user name of the personal account to be created."
}

variable "personal_user_password" {
  type        = string
  description = "The password of the personal account to be created."
}

variable "policy_pki_tvcx_issue_role" {
  type        = string
  description = "The role for pki."
  default     = "cons_dot_ul"
}
