# Consul agent configuration

# Enable ACLs.
acl {
    enabled                  = true
    default_policy           = "deny"
    down_policy              = "extend-cache"
    enable_token_persistence = true
    tokens {
        agent       = "{{ config_template.agent_token }}"
        replication = "{{ config_template.replication_token }}"
    }
}

# An address reachable by other Consul agents.
bind_addr   = "{{ config_template.bind_addr }}"
client_addr = "127.0.0.1"
{{#if config_template.enable_server }}
# Only enable bootstrap_expect if this agent is a server.
bootstrap_expect = {{ config_template.bootstrap_expect }}
{{/if}}
# TLS/SSL stuff
ca_file   = "/ssl/ca.pem"
cert_file = "/ssl/cert.pem"
key_file  = "/ssl/cert-key.pem"

# The standard data directory for Consul when ran in a Docker container.
data_dir = "/consul/config"

datacenter         = "{{ config_template.datacenter }}"
domain             = "{{ config_template.domain }}"
primary_datacenter = "tvcxair"
# Retry to join the other agents.
retry_join_wan     = [
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

server = {{ config_template.enable_server }}
ui     = {{ config_template.enable_ui }}

# Verify all outgoing communications.
verify_outgoing     = true
# Only require a TLS certificate for rpc(so that you can use the ui in a browser without a TLS
# certificate).
verify_incoming_rpc = true
