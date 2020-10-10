# Vault configuration

consul {
    address       = "localhost:8500"
    tls_cert_file = "/ssl/cert.pem"
    tls_key_file  = "/ssl/cert-key.pem"
    tls_ca_file   = "/ssl/ca.pem"
    ssl           = true
    # token         = "c7be9cb6-40dd-8743-bdd5-3c8d93591229"
}

listener "tcp" {
    address       = "10.125.66.0:8200"
    tls_cert_file = "/ssl/cert.pem"
    tls_key_file  = "/ssl/cert-key.pem"
}

storage "consul" {
    address       = "localhost:8500"
    path          = "vault/"
    scheme        = "https"
    # token         = "c7be9cb6-40dd-8743-bdd5-3c8d93591229"
    tls_cert_file = "/ssl/cert.pem"
    tls_key_file  = "/ssl/cert-key.pem"
    tls_ca_file   = "/ssl/ca.pem"
}

api_addr     = "https://10.125.66.0:8200"
cluster_addr = "https://10.125.66.0:8201"

ui = true
