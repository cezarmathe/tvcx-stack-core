# Policy for issuing certificates for tvcx pki.

path "pki/issue/${role}" {
    capabilities = ["create", "read", "update"]
}
