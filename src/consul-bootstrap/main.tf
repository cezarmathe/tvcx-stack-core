# consul-bootstrap

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
  config_consul0 = jsonencode(merge(local.common, local.consul0))
  config_consul1 = jsonencode(merge(local.common, local.consul1))
  config_consul2 = jsonencode(merge(local.common, local.consul2))
}

data "docker_registry_image" "consul0" {
  name = "consul:%{ if var.consul0_image_version != "" }${var.consul0_image_version}%{ else }${var.consul_image_version}%{ endif }"
}

data "docker_registry_image" "consul1" {
  name = "consul:%{ if var.consul1_image_version != "" }${var.consul1_image_version}%{ else }${var.consul_image_version}%{ endif }"
}

data "docker_registry_image" "consul2" {
  name = "consul:%{ if var.consul2_image_version != "" }${var.consul2_image_version}%{ else }${var.consul_image_version}%{ endif }"
}

resource "docker_image" "consul0" {
  provider      = docker.docker0
  name          = data.docker_registry_image.consul0.name
  pull_triggers = [data.docker_registry_image.consul0.sha256_digest]
}

resource "docker_image" "consul1" {
  provider      = docker.docker1
  name          = data.docker_registry_image.consul1.name
  pull_triggers = [data.docker_registry_image.consul1.sha256_digest]
}

resource "docker_image" "consul2" {
  provider      = docker.docker2
  name          = data.docker_registry_image.consul2.name
  pull_triggers = [data.docker_registry_image.consul2.sha256_digest]
}

resource "docker_container" "consul0" {
  provider = docker.docker0

  name  = "consul"
  image = docker_image.consul0.latest

  command = ["agent"]

  env = ["CONSUL_LOCAL_CONFIG=${local.config_consul0}"]

  network_mode = "host"

  # data volume
  volumes {
    host_path      = "%{ if var.consul0_host_data_volume_path != "" }${var.consul0_host_data_volume_path}%{ else }${var.host_data_volume_path}%{ endif }"
    container_path = "/consul/data"
  }

  # ssl certificates volume
  volumes {
    host_path      = "%{ if var.consul0_host_ssl_volume_path != "" }${var.consul0_host_ssl_volume_path}%{ else }${var.host_ssl_volume_path}%{ endif }"
    container_path = "/consul/ssl"
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

resource "docker_container" "consul1" {
  provider = docker.docker1

  name  = "consul"
  image = docker_image.consul1.latest

  command = ["agent"]

  env = ["CONSUL_LOCAL_CONFIG=${local.config_consul1}"]

  network_mode = "host"

  # data volume
  volumes {
    host_path      = "%{ if var.consul1_host_data_volume_path != "" }${var.consul1_host_data_volume_path}%{ else }${var.host_data_volume_path}%{ endif }"
    container_path = "/consul/data"
  }

  # ssl certificates volume
  volumes {
    host_path      = "%{ if var.consul1_host_ssl_volume_path != "" }${var.consul1_host_ssl_volume_path}%{ else }${var.host_ssl_volume_path}%{ endif }"
    container_path = "/consul/ssl"
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

resource "docker_container" "consul2" {
  provider = docker.docker2

  name  = "consul"
  image = docker_image.consul2.latest

  command = ["agent"]

  env = ["CONSUL_LOCAL_CONFIG=${local.config_consul2}"]

  network_mode = "host"

  # data volume
  volumes {
    host_path      = "%{ if var.consul2_host_data_volume_path != "" }${var.consul2_host_data_volume_path}%{ else }${var.host_data_volume_path}%{ endif }"
    container_path = "/consul/data"
  }

  # ssl certificates volume
  volumes {
    host_path      = "%{ if var.consul2_host_ssl_volume_path != "" }${var.consul2_host_ssl_volume_path}%{ else }${var.host_ssl_volume_path}%{ endif }"
    container_path = "/consul/ssl"
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
