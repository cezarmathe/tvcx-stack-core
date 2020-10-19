# Policy for gv users.

path "secret/data/git/{{identity.entity.aliases.userpass.name}}/*" {
    capabilities = ["create", "update", "read", "list", "delete"]
}

path "secret/data/git/{{identity.entity.aliases.userpass.name}}" {
    capabilities = ["create", "update", "read", "list", "delete"]
}

path "secret/metadata/git/{{identity.entity.aliases.userpass.name}}/*" {
    capabilities = ["read", "list"]
}
