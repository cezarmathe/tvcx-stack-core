# Policy for admins of the tvcx pki secrets engine.

path "pki_tvcx/config/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki_tvcx/roles/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}
