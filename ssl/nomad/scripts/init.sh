#!/usr/bin/env bash

# This script copies the CSR and cfssl config templates and creates the cert/ directory.

function main() {
    printf "%s\n" "Copying the CSR template to $(pwd)/csr.json"
    cp "$(pwd)/templates/csr.json" "$(pwd)/csr.json"

    printf "%s\n" "Copying the cfssl.conf template to $(pwd)/cfssl.conf"
    cp "$(pwd)/templates/cfssl.conf" "$(pwd)/cfssl.conf"

    printf "%s\n" "Creating the certificate output directory"
    mkdir "$(pwd)/cert"

    printf "%s\n" "Done!"
}

main $@
