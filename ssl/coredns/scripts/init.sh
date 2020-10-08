#!/usr/bin/env bash

# This script copies the CSR and cfssl config templates and creates the cert/ directory.

function main() {
    cp "$(pwd)/templates/csr.json" "$(pwd)/csr.json"
    cp "$(pwd)/templates/cfssl.conf" "$(pwd)/cfssl.conf"
    mkdir "$(pwd)/cert"
}

main $@
