# Policy for creating tokens for Vault.

key_prefix "vault/" {
    policy = "write"
}

node "" {
    policy = "write"
}

service "vault" {
    policy = "write"
}

agent "" {
    policy = "write"
}

session_prefix "" {
    policy = "write"
}
