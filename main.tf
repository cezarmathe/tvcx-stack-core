# tvcx-stack-core

terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
  required_version = ">= 0.13"
}

provider "docker" {
  host = "unix:///run/docker.sock"
}

data "docker_registry_image" "consul" {
  name = "consul:${var.consul_image_version}"
}

resource "docker_image" "consul" {
  name = data.docker_registry_image.consul.name
  pull_triggers = ["${data.docker_registry_image.consul.sha256_digest}"]
}

data "docker_registry_image" "coredns" {
  name = "coredns/coredns:${var.coredns_image_version}"
}

resource "docker_image" "coredns" {
  name = data.docker_registry_image.coredns.name
  pull_triggers = ["${data.docker_registry_image.coredns.sha256_digest}"]
}

data "docker_registry_image" "vault" {
  name = "vault:${var.vault_image_version}"
}

resource "docker_image" "vault" {
  name = data.docker_registry_image.vault.name
  pull_triggers = ["${data.docker_registry_image.vault.sha256_digest}"]
}

resource "docker_container" "consul" {
  name  = "consul"
  image = docker_image.consul.latest

  network_mode = "host"

  volumes {
    host_path      = "/srv/docker/consul/config"
    container_path = "/consul/config"
  }
  volumes {
    host_path      = "/srv/docker/consul/data"
    container_path = "/consul/data"
  }
  volumes {
    host_path      = "/srv/ssl/consul"
    container_path = "/ssl"
    read_only      = true
  }
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  # rm       = true
  start    = true

  depends_on = [
    docker_container.coredns
  ]
}

resource "docker_container" "coredns" {
  name  = "coredns"
  image = docker_image.coredns.latest

  command = ["-conf", "/config/Corefile"]

  ports {
    internal = 53
    external = 53
    protocol = "udp"
  }

  volumes {
    host_path      = "/srv/docker/coredns/config"
    container_path = "/config"
    read_only      = true
  }
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  # rm       = true
  start    = true
}

resource "docker_container" "fabio" {
  name  = "fabio"
  image = var.fabio_image_id

  command = ["-cfg", "/etc/fabio/fabio.properties", "-insecure"]

  network_mode = "fabio"

  volumes {
    host_path      = "/srv/docker/fabio/config"
    container_path = "/etc/fabio"
    read_only      = true
  }
  volumes {
    host_path      = "/srv/ssl/fabio"
    container_path = "/ssl"
    read_only      = true
  }
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  # rm       = true
  start    = true

  depends_on = [
    docker_container.vault
  ]
}

resource "docker_container" "vault" {
  name  = "vault"
  image = docker_image.vault.latest

  capabilities {
    add = ["IPC_LOCK"]
  }

  command = ["server"]

  network_mode = "host"

  volumes {
    host_path      = "/srv/docker/vault/config"
    container_path = "/vault/config"
  }
  volumes {
    host_path      = "/srv/docker/vault/logs"
    container_path = "/vault/logs"
  }
  volumes {
    host_path      = "/srv/ssl/vault"
    container_path = "/ssl"
    read_only      = true
  }
  volumes {
    host_path      = "/etc/ssl/certs"
    container_path = "/etc/ssl/certs"
    read_only      = true
  }

  must_run = true
  restart  = "unless-stopped"
  # rm       = true
  start    = true

  depends_on = [
    docker_container.consul
  ]
}
