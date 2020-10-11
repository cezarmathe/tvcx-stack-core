# Vault configuration

listener "tcp" {
    address       = "{{ config_template.listener_address }}"
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

ui = true
