#!/usr/bin/env bash

# This script will handle certificate requesting and hardlinking for all services.

function hardlink() {
    for dir in $(ls /srv/ssl); do
        printf "%s\n" "Hardlinking certificate for ${dir}"
        cd "/srv/ssl/${dir}"
        local hardlink_to
        hardlink_to="$(cat $(pwd)/srv_src.conf | grep hardlink_to | tr -s ' ' | cut -d ' ' -f 3)"
        ln "$(pwd)/cert/cert.pem" "${hardlink_to}/cert.pem"
        ln "$(pwd)/cert/cert-key.pem" "${hardlink_to}/cert-key.pem"
    done
    printf "%s\n" "Done!"

}

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

function main() {
    local cmd
    cmd="$1"; shift
    if [[ -z "${cmd}" ]]; then
        printf "%s\n" "Available commands: hardlink request"
        exit 1
    fi

    case "${cmd}" in
    "hardlink")
        hardlink
        ;;
    "request")
        request
        ;;
    *)
        printf "%s\n" "Available commands: hardlink request"
        ;;
    esac
}

main $@
