# container-alist

[![Build and Test Container](https://github.com/mogeko/container-alist/actions/workflows/test.yml/badge.svg)](https://github.com/mogeko/container-alist/actions/workflows/test.yml) [![Image Size](https://img.shields.io/docker/image-size/mogeko/alist?logo=docker)](https://github.com/mogeko/container-alist/pkgs/container/alist)

A distroless and rootless container for [Alist](https://github.com/alist-org/alist).

## Usage

Set up a Alist server with the following command:

> This container is designed to be used with [Podman](https://podman.io). For [Docker](https://www.docker.com), we suggest using [xhofe/alist](https://hub.docker.com/r/xhofe/alist).

```sh
podman run -d \
    --name alist \
    --userns=keep-id:uid=65532,gid=65532 \
    -v /path/to/save/data:/mnt/data \
    -p 5244:5244 \
    ghcr.io/mogeko/alist:latest
```

Then, set a password for the admin account:

```sh
# Randomly generate a password.
podman exec -it alist /usr/bin/alist admin random
# Set a password manually. Replace NEW_PASSWORD with your password.
podman exec -it alist /usr/bin/alist admin set NEW_PASSWORD
```

Finally, visit [`http://localhost:5244`](http://localhost:5244) and log in with the admin account.

For more information, please refer to the [Alist documentation](https://alist.nn.ci/guide).

## Environment Variables

You can use the environment variables that start with `ALIST_` to configure the Alist server.

For example, to set the [site url](https://alist.nn.ci/config/configuration.html#site-url) by: `-e ALIST_SITE_URL=https://example.com`.

The complete list of configure options is in the [Alist documentation](https://alist.nn.ci/config/configuration.html).

## UID/GID mapping

In the consideration of safety, the container runs as a non-root user with UID/GID **65532**.

At the same time, as a [distroless container](https://github.com/GoogleContainerTools/distroless), there is not a shell inside the container. Therefore, we cannot use `usermod` to change the UID/GID of the user inside the container. So we use the [`--userns`](https://docs.podman.io/en/v4.6.1/markdown/options/userns.container.html) option of podman to **map the UID/GID of the host to the UID/GID of the user inside the container**.

> **keep-id**: creates a user namespace where the current user's UID:GID are mapped to the same values in the container. For containers created by root, the current mapping is created into a new user namespace.
>
> Valid `keep-id` options:
>
> - _uid_=UID: override the UID inside the container that is used to map the current user to.
> - _gid_=GID: override the GID inside the container that is used to map the current user to.

Since (as I know) the Docker cannot map the UID/GID of the host to the specified UID/GID of the user inside the container, we suggest using Podman to run this container.

## "Distroless" Container Images

Learn more about [distroless container images](https://github.com/GoogleContainerTools/distroless).

## License

The code in this project is released under the [MIT License](./LICENSE).
