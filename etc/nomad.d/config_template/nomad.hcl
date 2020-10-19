# Nomad configuration

# The ACL section is commented because I need to research it a bit more.
# Enable ACLs.
acl {
    enabled = true
}

addresses {
    # Let the HTTPS interface be accessible localhost, too
    http = "{{ config_template.bind_addr }}"
}

bind_addr = "{{ config_template.bind_addr }}"

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

consul {
    address   = "{{ config_template.bind_addr }}:8500"
    ca_file   = "/srv/ssl/nomad/ca.pem"
    cert_file = "/srv/ssl/nomad/cert.pem"
    key_file  = "/srv/ssl/nomad/cert-key.pem"
    ssl       = true
    token     = "{{ config_template.consul_token }}"

    auto_advertise      = true
    client_service_name = "nomad-client"
    client_auto_join    = true
    server_service_name = "nomad-server"
    server_auto_join    = true

    tags = [
        "urlprefix-nomad.service.cons.ul/"
    ]
}

datacenter = "tvcxdc"
data_dir   = "/srv/nomad"

# Nomad server configuration.
server {
    enabled          = true
    bootstrap_expect = 3
}

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
    address = "https://{{ config_template.bind_addr }}:8200"

    ca_file   = "/srv/ssl/nomad/ca.pem"
    cert_file = "/srv/ssl/nomad/cert.pem"
    key_file  = "/srv/ssl/nomad/cert-key.pem"

    create_from_role = "nomad-role"
    task_token_ttl   = "1h"
    token            = "nomad-role"
}

# Enable mounting Docker volumes from outside the Nomad directory.
plugin "docker" {
    config {
        volumes {
            enabled = true
        }
    }
}

