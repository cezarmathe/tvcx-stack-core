# Policy for admins of the Nomad secrets engine.

path "nomad/config/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "nomad/role/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}
