# srv-src

Sources for the configuration of a few services deployed on my servers.

## Installation

```shell
# Start firewall
for dir in $(ls $(pwf)/ufw); do
    prev="$(pwd)"
    cd ${dir}
    ./start.sh
    cd ${prev}
done

```

## Deployment

```shell
docker-compose up -d
```
