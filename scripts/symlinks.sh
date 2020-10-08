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
        stow --dir "$(pwd)/docker" --target "/srv/docker" .
        stow --dir "$(pwd)/etc" --target "/etc" .
        stow --dir "$(pwd)/ssl" --target "/srv/ssl" .
        stow --dir "$(pwd)/ssl" --target "/srv/ufw" .
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
