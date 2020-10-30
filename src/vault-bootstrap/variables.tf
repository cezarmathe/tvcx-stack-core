# vault-bootstrap - variables

variable "docker0_host" {
  type        = string
  description = "Host for the first Docker provider"
}

variable "docker1_host" {
  type        = string
  description = "Host for the second Docker provider"
}

variable "docker2_host" {
  type        = string
  description = "Host for the third Docker provider"
}

variable "vault_image_version" {
  type        = string
  description = "Version of the vault docker image."
}

variable "host_ssl_volume_path" {
  type        = string
  description = "Path on the host that will be mounted as the ssl certificates storage directory."
  default     = "/etc/vault.d/ssl"
}

variable "vault0_consul_token" {
  type        = string
  description = "The Consul token used by the vault0 agent."
}

variable "vault0_addr" {
  type        = string
  description = "The network interface the vault0 agent will bind to."
}

variable "vault0_image_version" {
  type        = string
  description = "Version of the vault docker image for the vault0 agent."
  default     = ""
}

variable "vault0_host_ssl_volume_path" {
  type        = string
  description = "Path on the host of vault0 that will be mounted as the ssl certificates storage directory."
  default     = ""
}

variable "vault1_consul_token" {
  type        = string
  description = "The Consul token used by the vault1 agent."
}

variable "vault1_addr" {
  type        = string
  description = "The network interface the vault1 agent will bind to."
}

variable "vault1_image_version" {
  type        = string
  description = "Version of the vault docker image for the vault0 agent."
  default     = ""
}

variable "vault1_host_ssl_volume_path" {
  type        = string
  description = "Path on the host of vault1 that will be mounted as the ssl certificates storage directory."
  default     = ""
}

variable "vault2_consul_token" {
  type        = string
  description = "The Consul token used by the vault2 agent."
}

variable "vault2_addr" {
  type        = string
  description = "The network interface the vault2 agent will bind to."
}

variable "vault2_image_version" {
  type        = string
  description = "Version of the vault docker image for the vault0 agent."
  default     = ""
}

variable "vault2_host_ssl_volume_path" {
  type        = string
  description = "Path on the host of vault2 that will be mounted as the ssl certificates storage directory."
  default     = ""
}
