#!/usr/bin/env bash

# This script will handle bringing the firewall up or down for all services.

function start() {
    for dir in $(ls /srv/ufw); do
        printf "%s\n" "Starting firewall for ${dir}"
        cd "/srv/ufw/${dir}"
        ./start.sh
    done
    printf "%s\n" "Done!"
}

function stop() {
    for dir in $(ls /srv/ufw); do
        printf "%s\n" "Stopping firewall for ${dir}"
        cd "/srv/ufw/${dir}"
        ./stop.sh
    done
    printf "%s\n" "Done!"
}

function main() {
    local cmd
    cmd="$1"; shift
    if [[ -z "${cmd}" ]]; then
        printf "%s\n" "Available commands: start stop"
        exit 1
    fi

    case "${cmd}" in
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    *)
        printf "%s\n" "Available commands: start stop"
        ;;
    esac
}
