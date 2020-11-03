# nomad-core-config - variables

variable "consul_address" {
  type        = string
  description = "The address of the Consul agent."
}

variable "consul_token" {
  type        = string
  description = "The Consul token required by the Consul provider."
}

variable "datacenter" {
  type        = string
  description = "The datacenter to be used by Nomad."
}

variable "servers_retry_join" {
  type        = list(string)
  description = "A list of servers to join with."
  default     = []
}

variable "data_dir" {
  type        = string
  description = "The directory where Nomad should store persistent data."
  default     = "/var/lib/nomad"
}

variable "ssl_dir" {
  type        = string
  description = "The directory where Nomad should look for the certs and the private key."
  default     = "/etc/nomad.d/ssl"
}

variable "lan_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the LAN interface."
  default     = "22,51820" # SSH port and the default Wireguard port
}

variable "wg_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the Wireguard interface."
  default     = "22" # SSH port
}

### nomad0

variable "nomad0_data_dir" {
  type        = string
  description = "The directory where nomad0 should store persistent data."
  default     = ""
}

variable "nomad0_ssl_dir" {
  type        = string
  description = "The directory where nomad0 should look for the certs and the private key."
  default     = ""
}

variable "nomad0_consul_token" {
  type        = string
  description = "The directory where nomad0 should look for the certs and the private key."
}

variable "nomad0_vault_token" {
  type        = string
  description = "The directory where nomad0 should look for the certs and the private key."
}

variable "nomad0_lan_name" {
  type        = string
  description = "The name of the LAN host network for nomad0."
  default     = "nomad0_lan"
}

variable "nomad0_lan_cidr" {
  type        = string
  description = "The CIDR of the LAN interface for nomad0."
}

variable "nomad0_lan_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the LAN interface for nomad0."
  default     = ""
}

variable "nomad0_wg_name" {
  type        = string
  description = "The name of the Wireguard host network for nomad0."
  default     = "nomad0_wg"
}

variable "nomad0_wg_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the Wireguard interface for nomad0."
  default     = ""
}

variable "nomad0_wg_cidr" {
  type        = string
  description = "The CIDR of the Wireguard interface for nomad0."
}

### nomad1

variable "nomad1_data_dir" {
  type        = string
  description = "The directory where nomad1 should store persistent data."
  default     = ""
}

variable "nomad1_ssl_dir" {
  type        = string
  description = "The directory where nomad1 should look for the certs and the private key."
  default     = ""
}

variable "nomad1_consul_token" {
  type        = string
  description = "The directory where nomad1 should look for the certs and the private key."
}

variable "nomad1_vault_token" {
  type        = string
  description = "The directory where nomad1 should look for the certs and the private key."
}

variable "nomad1_lan_name" {
  type        = string
  description = "The name of the LAN host network for nomad1."
  default     = "nomad1_lan"
}

variable "nomad1_lan_cidr" {
  type        = string
  description = "The CIDR of the LAN interface for nomad1."
}

variable "nomad1_lan_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the LAN interface for nomad1."
  default     = ""
}

variable "nomad1_wg_name" {
  type        = string
  description = "The name of the Wireguard host network for nomad1."
  default     = "nomad1_wg"
}

variable "nomad1_wg_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the Wireguard interface for nomad1."
  default     = ""
}

variable "nomad1_wg_cidr" {
  type        = string
  description = "The CIDR of the Wireguard interface for nomad1."
}

### nomad2

variable "nomad2_data_dir" {
  type        = string
  description = "The directory where nomad2 should store persistent data."
  default     = ""
}

variable "nomad2_ssl_dir" {
  type        = string
  description = "The directory where nomad2 should look for the certs and the private key."
  default     = ""
}

variable "nomad2_consul_token" {
  type        = string
  description = "The directory where nomad2 should look for the certs and the private key."
}

variable "nomad2_vault_token" {
  type        = string
  description = "The directory where nomad2 should look for the certs and the private key."
}

variable "nomad2_lan_name" {
  type        = string
  description = "The name of the LAN host network for nomad2."
  default     = "nomad2_lan"
}

variable "nomad2_lan_cidr" {
  type        = string
  description = "The CIDR of the LAN interface for nomad2."
}

variable "nomad2_lan_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the LAN interface for nomad2."
  default     = ""
}

variable "nomad2_wg_name" {
  type        = string
  description = "The name of the Wireguard host network for nomad2."
  default     = "nomad2_wg"
}

variable "nomad2_wg_reserved_ports" {
  type        = string
  description = "A comma-separated list of ports reserved on the Wireguard interface for nomad2."
  default     = ""
}

variable "nomad2_wg_cidr" {
  type        = string
  description = "The CIDR of the Wireguard interface for nomad2."
}
