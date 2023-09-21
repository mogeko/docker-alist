# container-alist

A distroless and rootless container for [Alist](https://github.com/alist-org/alist).

## Usage

Set up a Alist server with the following command:

```sh
podman run -d \
    --name alist \
    --userns=keep-id:uid=65532,gid=65532 \
    -v /path/to/save/data:/opt/alist/data \
    -p 5244:5244 \
    ghcr.io/mogeko/alist:latest
```

> This container is designed to be used with [podman](https://podman.io/). For docker, we suggest using [xhofe/alist](https://hub.docker.com/r/xhofe/alist).

Then, set a password for the admin account:

```sh
# Randomly generate a password.
podman exec -it alist /usr/bin/alist admin random
# Set a password manually. Replace NEW_PASSWORD with your password.
podman exec -it alist /usr/bin/alist admin set NEW_PASSWORD
```

Finally, visit [`http://localhost:5244`](http://localhost:5244) and log in with the admin account.

For more information, please refer to the [Alist documentation](https://alist.nn.ci/guide).
