# Policy for admins of the pki secrets engine.

path "pki/config/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki/roles/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki/certs/*" {
    capabilities = ["read", "delete", "list"]
}
