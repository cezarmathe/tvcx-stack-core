# Policy for general users of the Consul secrets engine.
# This policy does NOT attempt to restrict usage to specific Consul roles.

path "consul/creds/*" {
    capabilities = ["read"]
}
