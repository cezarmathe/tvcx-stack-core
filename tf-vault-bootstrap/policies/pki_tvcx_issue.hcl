# Policy for issuing certificates for tvcx pki.

path "cubbyhole/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki/issue/${role}" {
    capabilities = ["create", "read", "update"]
}
