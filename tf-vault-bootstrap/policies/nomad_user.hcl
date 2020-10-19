# Policy for general users of the Nomad secrets engine.
# This policy does NOT attempt to restrict usage to specific Nomad roles.

path "nomad/creds/*" {
    capabilities = ["read"]
}
