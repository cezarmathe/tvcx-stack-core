# Policy for creating tokens for fabio.

node_prefix "" {
    policy = "read"
}

service_prefix "" {
    policy = "read"
}

service "fabio" {
    policy = "write"
}

agent_prefix "" {
    policy = "read"
}

key_prefix "fabio/" {
    policy = "write"
}
