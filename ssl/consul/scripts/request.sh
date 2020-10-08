#!/usr/bin/env bash

# This script will request a new certificate from the remote cfssl server.

function main() {
    printf "%s\n" "Loading configuration"
    local cfssl_remote
    cfssl_remote="$(cat $(pwd)/cfssl.conf | grep cfssl_remote | tr -s ' ' | cut -d ' ' -f 3)"
    local cfssl_profile
    cfssl_profile="$(cat $(pwd)/cfssl.conf | grep cfssl_remote | tr -s ' ' | cut -d ' ' -f 3)"

    printf "%s\n" "Requesting a certificate from the remote.."
    cfssl gencert \
        -remote="${cfssl_remote}" \
        -profile="${cfssl_profile}" \
        "$(pwd)/csr.json" | cfssljson -bare "$(pwd)/cert/cert"

    printf "%s\n" "Done!"
}

main $@
