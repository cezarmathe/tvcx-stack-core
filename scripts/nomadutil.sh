#!/usr/bin/env bash

# nomadutil - a utility script for Nomad

function start() {
    systemctl enable --now nomad
    printf "%s\n" "Done!"
}

function stop() {
    systemctl disable --now nomad
    printf "%s\n" "Done!"
}

function install() {
    local arch
    arch="$1"; shift
    local ver
    ver="$1"; shift

    wget "https://releases.hashicorp.com/nomad/${ver}/nomad_${ver}_linux_${arch}.zip" || exit 1
    unzip "nomad_${ver}_linux_${arch}.zip"
    mv nomad /usr/local/bin/nomad || rm nomad
    rm "nomad_${ver}_linux_${arch}.zip"

    if [[ -f "/etc/systend/system/nomad.service" ]]; then
        printf "%s\n" "Nomad service file already exists, not overriding."
        printf "%s\n" "Done!"
        return
    fi

    cat > /etc/systemd/systen/nomad.service <<EOF
[Unit]
Description=Nomad
Documentation=https://nomadproject.io/docs/
Wants=network-online.target
After=network-online.target

[Service]
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/nomad agent -config /etc/nomad.d
KillMode=process
KillSignal=SIGINT
LimitNOFILE=infinity
LimitNPROC=infinity
Restart=on-failure
RestartSec=2
StartLimitBurst=3
StartLimitIntervalSec=10
TasksMax=infinity

[Install]
WantedBy=multi-user.target
EOF
    printf "%s\n" "Done!"
}

function uninstall() {
    rm /usr/local/bin/nomad
    rm /etc/systemd/system/nomad.service
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
    "install")
        nomad_install $@
        ;;
    "uninstall")
        nomad_uninstall
        ;;
    "start")
        nomad_start
        ;;
    "stop")
        nomad_stop
        ;;
    *)
        printf "%s\n" "Available commands: install start stop uninstall"
        ;;
    esac
}

main $@
