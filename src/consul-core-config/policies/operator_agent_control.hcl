# Policy for creating tokens for operators that need to control the Consul agent.

# CLI Operations:
# * consul reload
# * consul monitor
# * consul leave
# * consul members

agent_prefix "" {
    policy = "write"
}

node_prefix "" {
    policy = "read"
}
