# Consul server configuration

acl {
    enabled                  = true
    default_policy           = "deny"
    down_policy              = "extend-cache"
    enable_token_persistence = true

    tokens {
        agent = ""
    }
}

bootstrap_expect = 1

# connect {
#     enabled     = true
#     ca_provider = "vault"
#     ca_config {
#         address               = "https://localhost:8200"
#         intermediate_pki_path = "connect-intermediate"
#         root_pki_path         = "connect-root"
#         token                 = "..."
#     }
# }

data_dir           = "/consul/config"

datacenter         = "{{ config_template.datacenter }}"
primary_datacenter = "tvcxair"

retry_join = [
    "10.125.42.0",
    "10.125.66.0",
    "10.125.169.0"
]

bind_addr   = "{{ config_template.bind_addr }}"
client_addr = "127.0.0.1"

performance {
    raft_multiplier = 5
}

server = true
ui     = true

verify_outgoing     = true
verify_incoming_rpc = true

cert_file = "/ssl/cert.pem"
key_file  = "/ssl/cert-key.pem"
ca_file   = "/ssl/ca.pem"

ports {
    http = -1
    https = 8500
}
