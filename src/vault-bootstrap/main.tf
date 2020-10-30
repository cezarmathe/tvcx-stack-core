# vault-bootstrap

terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
  required_version = ">= 0.13"
}

# Merge and jsonencode the custom configurations
locals {
  config_vault0 = jsonencode(merge(local.common, local.vault0))
  config_vault1 = jsonencode(merge(local.common, local.vault1))
  config_vault2 = jsonencode(merge(local.common, local.vault2))
}

data "docker_registry_image" "vault0" {
  name = "vault:%{ if var.vault0_image_version != "" }${var.vault0_image_version}%{ else }${var.vault_image_version}%{ endif }"
}

data "docker_registry_image" "vault1" {
  name = "vault:%{ if var.vault1_image_version != "" }${var.vault1_image_version}%{ else }${var.vault_image_version}%{ endif }"
}

data "docker_registry_image" "vault2" {
  name = "vault:%{ if var.vault2_image_version != "" }${var.vault2_image_version}%{ else }${var.vault_image_version}%{ endif }"
}

resource "docker_image" "vault0" {
  provider      = docker.docker0
  name          = data.docker_registry_image.vault0.name
  pull_triggers = [data.docker_registry_image.vault0.sha256_digest]
}

resource "docker_image" "vault1" {
  provider      = docker.docker1
  name          = data.docker_registry_image.vault1.name
  pull_triggers = [data.docker_registry_image.vault1.sha256_digest]
}

resource "docker_image" "vault2" {
  provider      = docker.docker2
  name          = data.docker_registry_image.vault2.name
  pull_triggers = [data.docker_registry_image.vault2.sha256_digest]
}

resource "docker_container" "vault0" {
  provider = docker.docker0

  name  = "vault"
  image = docker_image.vault0.latest

  capabilities {
    add = ["IPC_LOCK"]
  }

  command = ["server"]

  env = ["VAULT_LOCAL_CONFIG=${local.config_vault0}"]

  network_mode = "host"

  # ssl certificates volume
  volumes {
    host_path      = "%{ if var.vault0_host_ssl_volume_path != "" }${var.vault0_host_ssl_volume_path}%{ else }${var.host_ssl_volume_path}%{ endif }"
    container_path = "/vault/ssl"
  }

  # mount the trusted certificates of the host
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  start    = true
}

resource "docker_container" "vault1" {
  provider = docker.docker1

  name  = "vault"
  image = docker_image.vault1.latest

  capabilities {
    add = ["IPC_LOCK"]
  }

  command = ["server"]

  env = ["VAULT_LOCAL_CONFIG=${local.config_vault1}"]

  network_mode = "host"

  # ssl certificates volume
  volumes {
    host_path      = "%{ if var.vault1_host_ssl_volume_path != "" }${var.vault1_host_ssl_volume_path}%{ else }${var.host_ssl_volume_path}%{ endif }"
    container_path = "/vault/ssl"
  }

  # mount the trusted certificates of the host
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  start    = true
}

resource "docker_container" "vault2" {
  provider = docker.docker2

  name  = "vault"
  image = docker_image.vault2.latest

  capabilities {
    add = ["IPC_LOCK"]
  }

  command = ["server"]

  env = ["VAULT_LOCAL_CONFIG=${local.config_vault2}"]

  network_mode = "host"

  # ssl certificates volume
  volumes {
    host_path      = "%{ if var.vault2_host_ssl_volume_path != "" }${var.vault2_host_ssl_volume_path}%{ else }${var.host_ssl_volume_path}%{ endif }"
    container_path = "/vault/ssl"
  }

  # mount the trusted certificates of the host
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  start    = true
}
