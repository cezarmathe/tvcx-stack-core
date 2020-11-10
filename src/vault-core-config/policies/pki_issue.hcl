# Policy for issuing certificates from the pki secrets engine.

path "cubbyhole/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki/issue/${role}" {
    capabilities = ["create", "read", "update"]
}
