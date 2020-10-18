# srv-src

Sources for the configuration of a few services deployed on my servers.

## IDEAS

- you can send SIGHUP to hashi software to reload the config

## Project structure

- **docker** - data that will be mounted inside the Docker containers of core components

- **etc** - configurations to be symlinked to `/etc`

- **scripts** - a few scripts to prepare the machine(symlinks, hardlinks, certificates, firewall)

- **ssl** - instructions and data for the purpose of getting certificates for each core component

- **tf-\*** - Terraform code to perform advanced configuration on the core components

- **ufw** - firewall rules for the security of core components

## Steps

1. Clone this repository

2. Fill data files

You need to fill these files:

- ssl/consul/templates/eri.conf - data for the Consul certificate
- ssl/fabio/templates/eri.conf - data for the Fabio certificate
- ssl/vault/templates/eri.conf - data for the Vault certificate

- etc/nomad.d/config_template/eri.conf - data for the Nomad configuration file template

## Installation

```shell
./scripts/symlinks.sh do
./scripts/certificates.sh request
./scripts/certificates.sh hardlink
./scripts/firewall.sh start
```

## Deployment

```shell
docker-compose up -d
```
