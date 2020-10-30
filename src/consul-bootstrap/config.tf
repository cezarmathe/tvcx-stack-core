# consul-bootstrap - config

locals {
  # common acl configuration
  acl_common = {
    enabled                  = true
    default_policy           = "deny"
    down_policy              = "extend-cache"
    enable_token_persistence = true
    enable_token_replication = true
  }

  # common configuration accross all agents
  common = {
    # The default address reachable by agents.
    client_addr = "127.0.0.1"

    # Expect 3 servers to bootstrap the cluster.
    bootstrap_expect = 3

    # TLS/SLL stuff.
    ca_file   = "/consul/ssl/ca.pem"
    cert_file = "/consul/ssl/cert.pem"
    key_file  = "/consul/ssl/cert-key.pem"

    # The standard data directory for Consul when ran in a Docker container.
    data_dir = "/consul/data"

    datacenter         = var.datacenter
    # The domain used for Consul DNS requests.
    domain             = var.domain
    # If a primary datacenter is not specified, then the current datacenter is assumed as primary.
    primary_datacenter = "%{ if var.primary_datacenter != "" }${var.primary_datacenter}%{ else }${var.datacenter}%{ endif }"
    # Retry to join other servers.
    retry_join         = var.retry_join

    # You probably don't want log levels beneath INFO.
    log_level = var.log_level

    # Tune the performance of the consensus algorithm by specifying a value between 1 and 10.
    # https://www.consul.io/docs/agent/options#raft_multiplier
    performance = {
      raft_multiplier = var.raft_multiplier
    }

    # Disable the HTTP port and enable the HTTPS one instead.
    ports = {
      http  = -1
      https = 8500
    }

    server = true
    ui     = true

    # Verify all outgoing communications.
    verify_outgoing     = true
    # Only require a TLS certificate for rpc(so that you can use the ui in a browser without a TLS
    # certificate).
    verify_incoming_rpc = true
  }

  # acl configuration for consul0
  acl_consul0 = {
    tokens = {
      # Set the ACL tokens.
      agent = var.consul0_acl_tokens_agent
    }
  }

  # custom configuration for consul0
  consul0 = {
    acl = merge(local.acl_common, local.acl_consul0)

    # Make the HTTPS ui be available to the outside, too.
    addresses = {
      https = "{{ GetPrivateInterfaces | include \"network\" \"${var.consul0_bind_cidr}\" | attr \"address\" }} 127.0.0.1"
    }

    # The address on which Consul will be available to other agents.
    bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"${var.consul0_bind_cidr}\" | attr \"address\" }}"
  }

  # acl configuration for consul1
  acl_consul1 = {
    tokens = {
      # Set the ACL tokens.
      agent = var.consul1_acl_tokens_agent
    }
  }

  # custom configuration for consul1
  consul1 = {
    acl = merge(local.acl_common, local.acl_consul1)

    # Make the HTTPS ui be available to the outside, too.
    addresses = {
      https = "{{ GetPrivateInterfaces | include \"network\" \"${var.consul1_bind_cidr}\" | attr \"address\" }} 127.0.0.1"
    }

    # The address on which Consul will be available to other agents.
    bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"${var.consul1_bind_cidr}\" | attr \"address\" }}"
  }

  # acl configuration for consul0
  acl_consul2 = {
    tokens = {
      # Set the ACL tokens.
      agent = var.consul2_acl_tokens_agent
    }
  }

  # custom configuration for consul2
  consul2 = {
    acl = merge(local.acl_common, local.acl_consul2)

    # Make the HTTPS ui be available to the outside, too.
    addresses = {
      https = "{{ GetPrivateInterfaces | include \"network\" \"${var.consul2_bind_cidr}\" | attr \"address\" }} 127.0.0.1"
    }

    # The address on which Consul will be available to other agents.
    bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"${var.consul2_bind_cidr}\" | attr \"address\" }}"
  }
}
