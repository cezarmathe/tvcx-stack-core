#!/usr/bin/env bash

# This script will handle certificate requesting and hardlinking for all services.

function request() {
    for dir in $(ls $(pwd)/ssl); do
        printf "%s\n" "Requesting certificate for ${dir}"
        prev="$(pwd)"
        cd "$(pwd)/ssl/${dir}"
        ./scripts/request.sh
        cd "${prev}"
    done
    printf "%s\n" "Done!"
}

function gendata() {
    for dir in $(ls $(pwd)/ssl); do
        printf "%s\n" "Generating data file for ${dir}"
        prev="$(pwd)"
        cd "$(pwd)/ssl/${dir}"
        eri gendata
        cd "${prev}"
    done
    printf "%s\n" "Done!"
}

function main() {
    local cmd
    cmd="$1"; shift
    if [[ -z "${cmd}" ]]; then
        printf "%s\n" "Available commands: request"
        exit 1
    fi

    case "${cmd}" in
    "request")
        request
        ;;
    "gendata")
        gendata
        ;;
    *)
        printf "%s\n" "Available commands: gendata request"
        ;;
    esac
}

main $@
