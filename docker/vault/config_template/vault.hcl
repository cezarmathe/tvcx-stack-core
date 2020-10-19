# Vault configuration

listener "tcp" {
    address       = "{{ config_template.listener_address }}:8200"
    tls_cert_file = "/ssl/cert.pem"
    tls_key_file  = "/ssl/cert-key.pem"
}

storage "consul" {
    address       = "localhost:8500"
    path          = "vault/"
    scheme        = "https"
    token         = "{{ config_template.consul_token }}"
    tls_cert_file = "/ssl/cert.pem"
    tls_key_file  = "/ssl/cert-key.pem"
    tls_ca_file   = "/ssl/ca.pem"
}

service_registration "consul" {
    address         = "127.0.0.1:8500"
    scheme          = "https"
    # Register the Vault service in a way that can be picked up by fabio for proxying.
    service_tags    = "urlprefix-vault.service.cons.ul"
    service_address = "127.0.0.1:8200"
    token           = "{{ config_template.consul_token }}"
    tls_cert_file   = "/ssl/cert.pem"
    tls_key_file    = "/ssl/cert-key.pem"
    tls_ca_file     = "/ssl/ca.pem"
}

api_addr     = "https://{{ config_template.listener_address }}:8200"
cluster_addr = "https://{{ config_template.listener_address }}:8201"

ui = true
