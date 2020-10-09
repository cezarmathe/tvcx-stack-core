# tvcxca-cert

Template repository for requesting a certificate from an on-demand cfssl server.

## How to use

1. **Initialize**

Run `./scripts/init.sh`.

This script will copy the configurations from the `templates` directory and create the certificate
output directory(`cert`).

2. **Configure**

Edit the configuration file `cfssl.conf` to set the following parameters:

- `cfssl_remote` - the remote address of the cfssl server(can also be `http://127.0.0.1:8888` - the
default for a cfssl server that only server on localhost)
- `cfssl_profile` - the signing profile that should be used for signing your certificate(the
profiles should have be defined by the server)
- `cfssl_signer_label` - the label of the signing key that should be used

Edit the `csr.json` file to set the following parameters:

- `CN` - the Common Name attibute of your certificate
- `hosts` - the hostnames for which your certificate will work

3. **Request**

Run `./scripts/request.sh`.

This script will get you a key and certificate from the remote server and the certificate of the
signer.
