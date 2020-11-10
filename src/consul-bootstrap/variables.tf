# consul-bootstrap - variables

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

variable "consul_image_version" {
  type        = string
  description = "Version of the Consul docker image."
}

variable "host_data_volume_path" {
  type        = string
  description = "Path on the host that will be mounted as the data directory."
  default     = "/var/consul"
}

variable "host_ssl_volume_path" {
  type        = string
  description = "Path on the host that will be mounted as the ssl certificates storage directory."
  default     = "/etc/consul.d/ssl"
}

variable "datacenter" {
  type        = string
  description = "The datacenter of the Consul cluster."
}

variable "primary_datacenter" {
  type        = string
  description = "The primary datacenter. If this is the primary(or only) datacenter then you can leave this as default."
  default     = ""
}

variable "domain" {
  type        = string
  description = "The domain used for Consul DNS requests."
  default     = "consul"
}

variable "retry_join" {
  type        = list(string)
  description = "A list of Consul servers that all servers should join."
}

variable "log_level" {
  type        = string
  description = "The log level of the agents."
  default     = "warn"
}

# See https://www.consul.io/docs/agent/options#raft_multiplier
variable "raft_multiplier" {
  type        = number
  description = "Tune the performance of the consensus algorithm by specifying a value between 0 and 5."
  default     = 5
}

variable "consul0_acl_tokens_agent" {
  type        = string
  description = "The agent ACL token used by the consul0 agent."
}

variable "consul0_bind_cidr" {
  type        = string
  description = "The network interface the consul0 agent will bind to."
}

variable "consul0_image_version" {
  type        = string
  description = "Version of the Consul docker image for the consul0 agent."
  default     = ""
}

variable "consul0_host_data_volume_path" {
  type        = string
  description = "Path on the host of consul0 that will be mounted as the data directory."
  default     = ""
}

variable "consul0_host_ssl_volume_path" {
  type        = string
  description = "Path on the host of consul0 that will be mounted as the ssl certificates storage directory."
  default     = ""
}

variable "consul1_acl_tokens_agent" {
  type        = string
  description = "The agent ACL token used by the consul1 agent."
  default     = ""
}

variable "consul1_bind_cidr" {
  type        = string
  description = "The network interface the consul1 agent will bind to."
}

variable "consul1_image_version" {
  type        = string
  description = "Version of the Consul docker image for the consul0 agent."
  default     = ""
}

variable "consul1_host_data_volume_path" {
  type        = string
  description = "Path on the host of consul1 that will be mounted as the data directory."
  default     = ""
}

variable "consul1_host_ssl_volume_path" {
  type        = string
  description = "Path on the host of consul1 that will be mounted as the ssl certificates storage directory."
  default     = ""
}

variable "consul2_acl_tokens_agent" {
  type        = string
  description = "The agent ACL token used by the consul2 agent."
  default     = ""
}

variable "consul2_bind_cidr" {
  type        = string
  description = "The network interface the consul2 agent will bind to."
}

variable "consul2_image_version" {
  type        = string
  description = "Version of the Consul docker image for the consul0 agent."
  default     = ""
}

variable "consul2_host_data_volume_path" {
  type        = string
  description = "Path on the host of consul2 that will be mounted as the data directory."
  default     = ""
}

variable "consul2_host_ssl_volume_path" {
  type        = string
  description = "Path on the host of consul2 that will be mounted as the ssl certificates storage directory."
  default     = ""
}
