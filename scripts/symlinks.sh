#!/usr/bin/env bash

# This script will do or undo symlinks in the /srv directory.

function main() {
    local cmd
    cmd="$1"; shift
    if [[ -z "${cmd}" ]]; then
        printf "%s\n" "Available commands: do redo undo"
        exit 1
    fi

    case "${cmd}" in
    "do")
        stow --dir "$(pwd)/docker" --target "/srv/docker" .
        stow --dir "$(pwd)/etc" --target "/etc" .
        stow --dir "$(pwd)/ssl" --target "/srv/ssl" .
        stow --dir "$(pwd)/ufw" --target "/srv/ufw" .
        ;;
    "redo")
        stow --dir "$(pwd)/docker" --target "/srv/docker" --restow .
        stow --dir "$(pwd)/etc" --target "/etc" --restow .
        stow --dir "$(pwd)/ssl" --target "/srv/ssl" --restow .
        stow --dir "$(pwd)/ufw" --target "/srv/ufw" --restow .
        ;;
    "undo")
        stow --dir "$(pwd)/docker" --target "/srv/docker" --delete .
        stow --dir "$(pwd)/etc" --target "/etc" --delete .
        stow --dir "$(pwd)/ssl" --target "/srv/ssl" --delete .
        stow --dir "$(pwd)/ufw" --target "/srv/ufw" --delete .
        ;;
    *)
        printf "%s\n" "Available commands: do redo undo"
        exit 1
        ;;
    esac
}

main $@
