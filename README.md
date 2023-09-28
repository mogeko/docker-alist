# container-alist

[![Build and Test Container](https://github.com/mogeko/container-alist/actions/workflows/test.yml/badge.svg)](https://github.com/mogeko/container-alist/actions/workflows/test.yml) [![Image Size](https://img.shields.io/docker/image-size/mogeko/alist?logo=docker)](https://github.com/mogeko/container-alist/pkgs/container/alist)

A distroless and rootless container for [Alist](https://github.com/alist-org/alist).

## Usage

## For Docker Users

Set up a Alist server by [Docker](https://www.docker.com):

```sh
docker run -d --name alist --user 1000:1000 -v /path/to/save/data:/mnt/data -p 5244:5244 ghcr.io/mogeko/alist:latest
```

Or by [Docker Compose](https://docs.docker.com/compose):

```yaml
version: "3.8"

services:
  alist:
    image: ghcr.io/mogeko/alist:latest
    container_name: alist
    user: 1000:1000
    volumes:
      - /path/to/save/data:/mnt/data
    ports:
      - 5244:5244
```

## For Podman Users

Set up a Alist server by [Podman](https://podman.io):

```sh
podman run -d --name alist --userns=auto -v /path/to/save/data:/mnt/data -p 5244:5244 ghcr.io/mogeko/alist:latest
```

## First Run

Set a password for the admin account:

```sh
# Randomly generate a password.
docker exec -it alist /usr/bin/alist --data /mnt/data admin random
# Set a password manually. Replace NEW_PASSWORD with your password.
docker exec -it alist /usr/bin/alist --data /mnt/data admin set NEW_PASSWORD
```

Finally, visit [`http://localhost:5244`](http://localhost:5244) and log in with the admin account.

For more information, please refer to the [Alist documentation](https://alist.nn.ci/guide).

## Environment Variables

You can use the environment variables that start with `ALIST_` to configure the Alist server.

For example, to set the [site url](https://alist.nn.ci/config/configuration.html#site-url) by: `-e ALIST_SITE_URL=https://example.com`.

The complete list of configure options is in the [Alist documentation](https://alist.nn.ci/config/configuration.html).

## "Distroless" Container Images

Learn more about [distroless container images](https://github.com/GoogleContainerTools/distroless).

## License

The code in this project is released under the [MIT License](./LICENSE).
