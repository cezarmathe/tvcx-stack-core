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
        stow --dir "$(pwd)/ufw" --target "/srv/ufw" .
        for dir in $(ls $(pwd)/ssl); do
            mkdir -p "/srv/ssl/${dir}"
            for file in $(ls $(pwd)/ssl/${dir}/cert); do
                ln "$(pwd)/ssl/${dir}/cert/${file}" "/srv/ssl/${dir}/${file}"
            done
        done
        printf "%s\n" "Done!"
        ;;
    "redo")
        stow --dir "$(pwd)/docker" --target "/srv/docker" --restow .
        stow --dir "$(pwd)/etc" --target "/etc" --restow .
        stow --dir "$(pwd)/ufw" --target "/srv/ufw" --restow .
        rm -rf /srv/ssl/*
        for dir in $(ls $(pwd)/ssl); do
            mkdir -p "/srv/ssl/${dir}"
            for file in $(ls $(pwd)/ssl/${dir}/cert); do
                ln "$(pwd)/ssl/${dir}/cert/${file}" "/srv/ssl/${dir}/${file}"
            done
        done
        printf "%s\n" "Done!"
        ;;
    "undo")
        stow --dir "$(pwd)/docker" --target "/srv/docker" --delete .
        stow --dir "$(pwd)/etc" --target "/etc" --delete .
        stow --dir "$(pwd)/ufw" --target "/srv/ufw" --delete .
        rm -rf /srv/ssl/*
        printf "%s\n" "Done!"
        ;;
    *)
        printf "%s\n" "Available commands: do redo undo"
        exit 1
        ;;
    esac
}

main $@
