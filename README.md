# srv-src

Sources for the configuration of a few services deployed on my servers.

## Installation

```shell
# Symlink all reqired files
stow --dir "$(pwd)/docker" --target-dir "/srv/docker"
stow --dir "$(pwd)/etc" --target-dir "/etc"
stow --dir "$(pwd)/ssl" --target-dir "/srv/ssl"
stow --dir "$(pwd)/ssl" --target-dir "/srv/ufw"

# Request all certificates
for dir in $(ls $(pwd)/ssl); do
    prev="$(pwd)"
    cd ${dir}
    ./scripts/request.sh
    cd ${prev}
done

# Hardlink all certificates

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
