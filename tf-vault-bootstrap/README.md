# vault-bootstrap

A Terraform module that configures a fresh Vault.

The Vault must be unsealed.

## Security

The `tfstate.json` file may contain sensitive information.

Use `VAULT_ADDR` and `VAULT_TOKEN` for providing provider information.
