# Nomad configuration

# The ACL section is commented because I need to research it a bit more.
# # Enable ACLs.
# acl {
#     enabled = true
# }

bind_addr = "{{ config_template.bind_addr }}"

{{#if config_template.client}}
# Nomad client configuration.
client {
    enabled = true

    # Volume for mounting the trusted TLS certificates.
    # This is useful for getting a private CA to be trusted by VMs/containers.
    host_volume "ca-certificates" {
        path      = "/etc/ssl/certs"
        read_only = true
    }

    # Volume for syncrhonizing the local time.
    host_volume "localtime" {
        path      = "/etc/localtime"
        read_only = true
    }
}
{{/if}}

consul {
    address   = "localhost:8500"
    ca_file   = "/srv/ssl/nomad/ca.pem"
    cert_file = "/srv/ssl/nomad/cert.pem"
    key_file  = "/srv/ssl/nomad/cert-key.pem"
    ssl       = true
    token     = "{{ config_template.consul_token }}"

    auto_advertise      = true
{{#if config_template.client}}
    client_service_name = "{{ config_template.client_service_name }}"
    client_auto_join    = true
{{/if}}
{{#if config_template.server}}
    server_service_name = "{{ config_template.server_service_name }}"
    server_auto_join    = true
{{/if}}
}

datacenter = "{{ config_template.datacenter }}"
data_dir   = "/srv/nomad"

{{#if config_template.server}}
# Nomad server configuration.
server {
    enabled          = true
    bootstrap_expect = {{ config_template.server_bootstrap_expect }}
}
{{/if}}

# Join other Nomad servers.
server_join {
    retry_join = [ "10.125.42.0", "10.125.66.0", "10.125.169.0" ]
    retry_interval = "15s"
}

# Enable Nomad telemetry.
telemetry {
    collection_interval        = "1s"
    disable_hostname           = false
    prometheus_metrics         = true
    publish_allocation_metrics = true
    publish_node_metrics       = true
}

tls {
    http = true
    rpc  = true

    ca_file                = "/srv/ssl/nomad/ca.pem"
    cert_file              = "/srv/ssl/nomad/cert.pem"
    key_file               = "/srv/ssl/nomad/cert-key.pem"
    verify_server_hostname = true
}

vault {
    enabled = true
    address = "https://localhost:8200"

    ca_file   = "/srv/ssl/nomad/ca.pem"
    cert_file = "/srv/ssl/nomad/cert.pem"
    key_file  = "/srv/ssl/nomad/cert-key.pem"

    create_from_role = "{{ config_template.vault_role }}"
    task_token_ttl   = "1h"
    token            = "{{ config_template.vault_token }}"
}

# Enable mounting Docker volumes from outside the Nomad directory.
plugin "docker" {
    config {
        volumes {
            enabled = true
        }
    }
}

