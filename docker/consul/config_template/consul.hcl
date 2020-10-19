# Consul agent configuration

# Enable ACLs.
acl {
    enabled                  = true
    default_policy           = "deny"
    down_policy              = "extend-cache"
    enable_token_persistence = true
    enable_token_replication = true
    tokens {
        agent       = "{{ config_template.agent_token }}"
        replication = "{{ config_template.replication_token }}"
    }
}

addresses {
    # Let the HTTPS interface be accessible from outside
    https = "{{ config_template.bind_addr }}"
}

# An address reachable by other Consul agents.
bind_addr   = "{{ config_template.bind_addr }}"
# The default address reachable by clients.
client_addr = "127.0.0.1"

# Require 3 servers to bootstrap the cluster
bootstrap_expect = 3

# TLS/SSL stuff
ca_file   = "/ssl/ca.pem"
cert_file = "/ssl/cert.pem"
key_file  = "/ssl/cert-key.pem"

# The standard data directory for Consul when ran in a Docker container.
data_dir = "/consul/config"

datacenter         = "tvcxdc"
domain             = "cons.ul"
primary_datacenter = "tvcxdc"
# Retry to join the other agents.
retry_join         = [
    "10.125.42.0",
    "10.125.66.0",
    "10.125.169.0"
]

# Make sure you do not have DEBUG messages.
log_level = "info"

# Keep the raft multiplier high since my machines are not in a cloud.
performance {
    raft_multiplier = 5
}

# Disable the http port and replace it with https.
ports {
    http = -1
    https = 8500
}

server = true
ui     = true

# Verify all outgoing communications.
verify_outgoing     = true
# Only require a TLS certificate for rpc(so that you can use the ui in a browser without a TLS
# certificate).
verify_incoming_rpc = true
