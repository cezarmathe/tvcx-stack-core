#!/usr/bin/env bash

# nomadutil - a utility script for Nomad

function nomad_start() {
    systemctl enable --now nomad
    printf "%s\n" "Done!"
}

function nomad_stop() {
    systemctl disable --now nomad
    printf "%s\n" "Done!"
}

function nomad_install() {
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

    cat > /etc/systemd/system/nomad.service <<EOF
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

function nomad_uninstall() {
    rm /usr/local/bin/nomad
    rm /etc/systemd/system/nomad.service
    printf "%s\n" "Done!"
}

function nomad_cni() {
    local arch
    arch="$1"; shift
    local ver
    ver="$1"; shift
    curl -L -o \
        cni-plugins.tgz \
        "https://github.com/containernetworking/plugins/releases/download/v${ver}/cni-plugins-linux-${arch}-v${ver}.tgz"
    mkdir -p /opt/cni/bin
    tar -C /opt/cni/bin -xzf cni-plugins.tgz
    rm cni-plugins.tgz
}

function main() {
    local cmd
    cmd="$1"; shift
    if [[ -z "${cmd}" ]]; then
        printf "%s\n" "Available commands: install start stop uninstall cni"
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
    "cni")
        nomad_cni $@
        ;;
    *)
        printf "%s\n" "Available commands: install start stop uninstall cni"
        ;;
    esac
}

main $@
