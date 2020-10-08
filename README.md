# srv-src

Sources for the configuration of a few services deployed on my servers.

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
