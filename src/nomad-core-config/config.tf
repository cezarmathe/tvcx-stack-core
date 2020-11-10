# nomad-core-config - config

locals {
  # Common Consul configuration for Nomad.
  common_consul = {
    address   = "127.0.0.1:8500"
    ssl       = true

    auto_advertise      = true
    client_service_name = "nomad-client"
    client_auto_join    = true
    server_service_name = "nomad-server"
    server_auto_join    = true

    tags = [
      "urlprefix-nomad-server.service.cons.ul/",
      "urlprefix-nomad-client.service.cons.ul/"
    ]
  }

  # Common Nomad TLS configuration.
  common_tls = {
    http = true
    rpc  = true
    verify_server_hostname = true
  }

  # Common Vault configuration for Nomad.
  common_vault = {
    enabled = true
    address = "https://127.0.0.1:8200"

    create_from_role = "nomad-role"
    task_token_ttl   = "1h"
  }

  # Common Nomad client configuration.
  common_client = {
    enabled = true

    host_volume = {
      # Volume for mounting the trusted TLS certificates.
      # This is useful for getting a private CA to be trusted by VMs/containers.
      ca-certificates = {
        path      = "/etc/ssl/certs"
        read_only = true
      }
      # Volume for syncrhonizing the local time.
      localtime = {
        path      = "/etc/localtime"
        read_only = true
      }
    }
  }

  # Common Nomad configuration.
  common = {
    # Enable ACLs.
    acl = {
      enabled = true
    }

    bind_addr = "0.0.0.0"

    datacenter = var.datacenter

    # Nomad server configuration.
    server = {
        enabled          = true
        bootstrap_expect = 3
    }

    # Join other Nomad servers.
    server_join = {
        retry_join = var.servers_retry_join
        retry_interval = "15s"
    }

    # Enable Nomad telemetry.
    telemetry = {
        collection_interval        = "1s"
        disable_hostname           = false
        prometheus_metrics         = true
        publish_allocation_metrics = true
        publish_node_metrics       = true
    }
  }

  # SSL directory to be used by nomad0.
  nomad0_ssl_dir = "%{ if var.nomad0_ssl_dir != "" }${var.nomad0_ssl_dir}%{ else }${var.ssl_dir}%{ endif }"

  # Consul configuration for nomad0.
  nomad0_consul = {
    ca_file   = "${local.nomad0_ssl_dir}/ca.pem"
    cert_file = "${local.nomad0_ssl_dir}/cert.pem"
    key_file  = "${local.nomad0_ssl_dir}/cert-key.pem"
    token     = var.nomad0_consul_token
  }

  # TLS configuration for nomad0.
  nomad0_tls = {
    ca_file   = "${local.nomad0_ssl_dir}/ca.pem"
    cert_file = "${local.nomad0_ssl_dir}/cert.pem"
    key_file  = "${local.nomad0_ssl_dir}/cert-key.pem"
  }

  # Vault configuration for nomad0.
  nomad0_vault = {
    ca_file   = "${local.nomad0_ssl_dir}/ca.pem"
    cert_file = "${local.nomad0_ssl_dir}/cert.pem"
    key_file  = "${local.nomad0_ssl_dir}/cert-key.pem"
    token     = var.nomad0_vault_token
  }

  # Client configuration for nomad0.
  nomad0_client = {
    host_network = {
      (var.nomad0_lan_name) = {
        cidr = var.nomad0_lan_cidr
        reserved_ports = "%{ if var.nomad0_lan_reserved_ports != "" }${var.nomad0_lan_reserved_ports}%{ else }${var.lan_reserved_ports}%{ endif }"
      }
      (var.nomad0_wg_name) = {
        cidr = "${var.nomad0_wg_addr}/24"
        reserved_ports = "%{ if var.nomad0_wg_reserved_ports != "" }${var.nomad0_wg_reserved_ports}%{ else }${var.wg_reserved_ports}%{ endif }"
      }
    }
  }

  # Specific nomad0 configuration
  nomad0 = {
    consul = merge(local.common_consul, local.nomad0_consul)
    tls    = merge(local.common_tls,    local.nomad0_tls)
    vault  = merge(local.common_vault,  local.nomad0_vault)
    client = merge(local.common_client, local.nomad0_client)

    addresses = {
      rpc  = var.nomad0_wg_addr
      serf = var.nomad0_wg_addr
    }

    advertise = {
      http = var.nomad0_wg_addr
    }

    data_dir   = "%{ if var.nomad0_data_dir != "" }${var.nomad0_data_dir}%{ else }${var.data_dir}%{ endif }"
  }

  # SSL directory to be used by nomad1.
  nomad1_ssl_dir = "%{ if var.nomad1_ssl_dir != "" }${var.nomad1_ssl_dir}%{ else }${var.ssl_dir}%{ endif }"

  # Consul configuration for nomad1.
  nomad1_consul = {
    ca_file   = "${local.nomad1_ssl_dir}/ca.pem"
    cert_file = "${local.nomad1_ssl_dir}/cert.pem"
    key_file  = "${local.nomad1_ssl_dir}/cert-key.pem"
    token     = var.nomad1_consul_token
  }

  # TLS configuration for nomad1.
  nomad1_tls = {
    ca_file   = "${local.nomad1_ssl_dir}/ca.pem"
    cert_file = "${local.nomad1_ssl_dir}/cert.pem"
    key_file  = "${local.nomad1_ssl_dir}/cert-key.pem"
  }

  # Vault configuration for nomad1.
  nomad1_vault = {
    ca_file   = "${local.nomad1_ssl_dir}/ca.pem"
    cert_file = "${local.nomad1_ssl_dir}/cert.pem"
    key_file  = "${local.nomad1_ssl_dir}/cert-key.pem"
    token     = var.nomad1_vault_token
  }

  # Client configuration for nomad1.
  nomad1_client = {
    host_network = {
      (var.nomad1_lan_name) = {
        cidr = var.nomad1_lan_cidr
        reserved_ports = "%{ if var.nomad1_lan_reserved_ports != "" }${var.nomad1_lan_reserved_ports}%{ else }${var.lan_reserved_ports}%{ endif }"
      }
      (var.nomad1_wg_name) = {
        cidr = "${var.nomad1_wg_addr}/24"
        reserved_ports = "%{ if var.nomad1_wg_reserved_ports != "" }${var.nomad1_wg_reserved_ports}%{ else }${var.wg_reserved_ports}%{ endif }"
      }
    }
  }

  # Specific nomad1 configuration
  nomad1 = {
    consul = merge(local.common_consul, local.nomad1_consul)
    tls    = merge(local.common_tls,    local.nomad1_tls)
    vault  = merge(local.common_vault,  local.nomad1_vault)
    client = merge(local.common_client, local.nomad1_client)

    addresses = {
      rpc  = var.nomad1_wg_addr
      serf = var.nomad1_wg_addr
    }

    advertise = {
      http = var.nomad1_wg_addr
    }

    data_dir   = "%{ if var.nomad1_data_dir != "" }${var.nomad1_data_dir}%{ else }${var.data_dir}%{ endif }"
  }

  # SSL directory to be used by nomad2.
  nomad2_ssl_dir = "%{ if var.nomad2_ssl_dir != "" }${var.nomad2_ssl_dir}%{ else }${var.ssl_dir}%{ endif }"

  # Consul configuration for nomad2.
  nomad2_consul = {
    ca_file   = "${local.nomad2_ssl_dir}/ca.pem"
    cert_file = "${local.nomad2_ssl_dir}/cert.pem"
    key_file  = "${local.nomad2_ssl_dir}/cert-key.pem"
    token     = var.nomad2_consul_token
  }

  # TLS configuration for nomad2.
  nomad2_tls = {
    ca_file   = "${local.nomad2_ssl_dir}/ca.pem"
    cert_file = "${local.nomad2_ssl_dir}/cert.pem"
    key_file  = "${local.nomad2_ssl_dir}/cert-key.pem"
  }

  # Vault configuration for nomad2.
  nomad2_vault = {
    ca_file   = "${local.nomad2_ssl_dir}/ca.pem"
    cert_file = "${local.nomad2_ssl_dir}/cert.pem"
    key_file  = "${local.nomad2_ssl_dir}/cert-key.pem"
    token     = var.nomad2_vault_token
  }

  # Client configuration for nomad2.
  nomad2_client = {
    host_network = {
      (var.nomad2_lan_name) = {
        cidr = var.nomad2_lan_cidr
        reserved_ports = "%{ if var.nomad2_lan_reserved_ports != "" }${var.nomad2_lan_reserved_ports}%{ else }${var.lan_reserved_ports}%{ endif }"
      }
      (var.nomad2_wg_name) = {
        cidr = "${var.nomad2_wg_addr}/24"
        reserved_ports = "%{ if var.nomad2_wg_reserved_ports != "" }${var.nomad2_wg_reserved_ports}%{ else }${var.wg_reserved_ports}%{ endif }"
      }
    }
  }

  # Specific nomad2 configuration
  nomad2 = {
    consul = merge(local.common_consul, local.nomad2_consul)
    tls    = merge(local.common_tls,    local.nomad2_tls)
    vault  = merge(local.common_vault,  local.nomad2_vault)
    client = merge(local.common_client, local.nomad2_client)

    addresses = {
      rpc  = var.nomad2_wg_addr
      serf = var.nomad2_wg_addr
    }

    advertise = {
      http = var.nomad2_wg_addr
    }

    data_dir   = "%{ if var.nomad2_data_dir != "" }${var.nomad2_data_dir}%{ else }${var.data_dir}%{ endif }"
  }
}
