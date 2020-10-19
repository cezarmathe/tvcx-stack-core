# Policy for gv admins.

path "secret/data/git/*" {
    capabilities = ["create", "update", "read", "list", "delete"]
}

path "secret/metadata/git/*" {
    capabilities = ["create", "update", "read", "list", "delete"]
}
