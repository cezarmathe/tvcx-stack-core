# Policy for Consul agent replication tokens.

acl = "write"

operator = "write"

service_prefix "" {
  policy = "read"
  intentions = "read"
}
