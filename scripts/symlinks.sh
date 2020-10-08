#!/usr/bin/env bash

# This script will do or undo symlinks in the /srv directory.

function main() {
    local cmd
    cmd="$1"; shift
    if [[ -z "${cmd}" ]]; then
        printf "%s\n" "Available commands: do undo"
        exit 1
    fi

    case "${cmd}" in
    "do")
        stow --dir "$(pwd)/docker" --target-dir "/srv/docker" .
        stow --dir "$(pwd)/etc" --target-dir "/etc" .
        stow --dir "$(pwd)/ssl" --target-dir "/srv/ssl" .
        stow --dir "$(pwd)/ssl" --target-dir "/srv/ufw" .
        ;;
    "undo")
        ;;
    *)
        printf "%s\n" "Available commands: do undo"
        exit 1
        ;;
    esac
}

main $@
