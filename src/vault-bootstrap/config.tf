# vault-bootstrap - config

locals {
  # common tcp listener configuration
  common_listener_tcp = {
    tls_cert_file = "/vault/ssl/cert.pem"
    tls_key_file  = "/vault/ssl/cert-key.pem"
  }

  # common consul storage configuration
  common_storage_consul = {
    address       = "127.0.0.1:8500"
    path          = "vault/"
    scheme        = "https"
    tls_cert_file = "/vault/ssl/cert.pem"
    tls_key_file  = "/vault/ssl/cert-key.pem"
    tls_ca_file   = "/vault/ssl/ca.pem"
  }

  # common consul service registration configuration
  common_service_registration_consul = {
    address         = "127.0.0.1:8500"
    scheme          = "https"
    # Register the Vault service in a way that can be picked up by fabio for proxying.
    service_tags    = "urlprefix-vault.service.cons.ul"
    tls_cert_file   = "/vault/ssl/cert.pem"
    tls_key_file    = "/vault/ssl/cert-key.pem"
    tls_ca_file     = "/vault/ssl/ca.pem"
  }

  # common configuration accross all agents
  common = {
    # the localhost-only listener
    listener = {
      tcp = {
        address       = "127.0.0.1:8200"
        tls_cert_file = "/vault/ssl/cert.pem"
        tls_key_file  = "/vault/ssl/cert-key.pem"
      }
    }

    # enable the ui
    ui = true
  }

  # custom tcp listener configuration for vault0
  vault0_listener_tcp = {
    address = "${var.vault0_addr}:8200"
  }

  # custom consul storage configuration for vault0
  vault0_storage_consul = {
    token = var.vault0_consul_token
  }

  # custom consul service registration configuration for vault0
  vault0_service_registration_consul = {
    token = var.vault0_consul_token
  }

  # custom configuration for vault0
  vault0 = {
    listener = {
      tcp = merge(local.common_listener_tcp, local.vault0_listener_tcp)
    }

    storage = {
      consul = merge(local.common_storage_consul, local.vault0_storage_consul)
    }

    service_registration = {
      consul = merge(local.common_service_registration_consul, local.vault0_service_registration_consul)
    }

    api_addr     = "https://${var.vault0_addr}:8200"
    cluster_addr = "https://${var.vault0_addr}:8201"
  }

  # custom tcp listener configuration for vault1
  vault1_listener_tcp = {
    address = "${var.vault1_addr}:8200"
  }

  # custom consul storage configuration for vault1
  vault1_storage_consul = {
    token = var.vault1_consul_token
  }

  # custom consul service registration configuration for vault1
  vault1_service_registration_consul = {
    token = var.vault1_consul_token
  }

  # custom configuration for vault1
  vault1 = {
    listener = {
      tcp = merge(local.common_listener_tcp, local.vault1_listener_tcp)
    }

    storage = {
      consul = merge(local.common_storage_consul, local.vault1_storage_consul)
    }

    service_registration = {
      consul = merge(local.common_service_registration_consul, local.vault1_service_registration_consul)
    }

    api_addr     = "https://${var.vault1_addr}:8200"
    cluster_addr = "https://${var.vault1_addr}:8201"
  }

  # custom tcp listener configuration for vault2
  vault2_listener_tcp = {
    address = "${var.vault2_addr}:8200"
  }

  # custom consul storage configuration for vault2
  vault2_storage_consul = {
    token = var.vault2_consul_token
  }

  # custom consul service registration configuration for vault2
  vault2_service_registration_consul = {
    token = var.vault2_consul_token
  }

  # custom configuration for vault2
  vault2 = {
    listener = {
      tcp = merge(local.common_listener_tcp, local.vault2_listener_tcp)
    }

    storage = {
      consul = merge(local.common_storage_consul, local.vault2_storage_consul)
    }

    service_registration = {
      consul = merge(local.common_service_registration_consul, local.vault2_service_registration_consul)
    }

    api_addr     = "https://${var.vault2_addr}:8200"
    cluster_addr = "https://${var.vault2_addr}:8201"
  }
}
