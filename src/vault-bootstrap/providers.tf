# vault-bootstrap - providers

# 1st docker provider
provider "docker" {
  alias = "docker0"
  host  = var.docker0_host
}

# 2nd docker provider
provider "docker" {
  alias = "docker1"
  host  = var.docker1_host
}

# 3rd docker provider
provider "docker" {
  alias = "docker2"
  host  = var.docker2_host
}
