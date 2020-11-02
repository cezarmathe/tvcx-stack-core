# Policy for admins of the Consul secrets engine.

path "consul/config/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

path "consul/roles/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}
