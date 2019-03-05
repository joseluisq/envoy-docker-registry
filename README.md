# Envoy / Docker Registry [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/joseluisq/envoy-docker-registry.svg)](https://hub.docker.com/r/joseluisq/envoy-docker-registry)

> [Envoy / Alpine](https://hub.docker.com/r/envoyproxy/envoy-alpine) and [Docker Registry](https://hub.docker.com/_/registry) x86_64 image.

## Overview

This image contains [Envoy](https://github.com/envoyproxy/envoy/blob/master/ci/Dockerfile-envoy-alpine) and [Docker Registry](https://github.com/docker/distribution-library-image) binaries as well as [Alpine](https://github.com/frol/docker-alpine-glibc) x86_64 for using it as an Envoy Service together with your Envoy Proxy.

## Usage

```sh
docker run --rm -it joseluisq/envoy-docker-registry:latest
```

### Dockerfile

You can also use the image as a base for your own Dockerfile:

```Dockerfile
FROM joseluisq/envoy-docker-registry:latest
```

### Docker Compose

Below a [Front Proxy](https://www.envoyproxy.io/docs/envoy/latest/start/sandboxes/front_proxy) example using `docker-registry` as an Envoy service:

```yml
version: "3.3"

services:
  # Envoy proxy
  front-proxy:
    image: envoyproxy/envoy:latest
    command: /usr/local/bin/envoy -c /etc/envoy-front-proxy.yaml --service-cluster front-proxy
    volumes:
      - ./front-proxy.envoy.yaml:/etc/envoy-front-proxy.yaml
    networks:
      - envoymesh
    ports:
      - "80:80"
      - "8001:8001"

  # Envoy Service
  docker-registry:
    restart: unless-stopped
    image: joseluisq/envoy-docker-registry:latest
    environment:
      # Docker Registry env variable
      - REGISTRY_HTTP_ADDR=0.0.0.0:5000
      # Envoy service name
      - SERVICE_NAME=docker_registry
    volumes:
      - registry_data:/var/lib/registry
      - ./docker-registry.envoy.yaml:/etc/envoy-service.yaml
    networks:
      envoymesh:
        aliases:
          - docker_registry

volumes:
  registry_data:

networks:
  envoymesh:
    external:
      name: envoymesh
```

## Options

### Envoy

- `SERVICE_NAME` : The name of the Envoy service.

### Docker Registry

[All configuration variables](https://docs.docker.com/registry/configuration/) like `REGISTRY_HTTP_ADDR`, etc.

## Contributions

Feel free to send some [Pull request](https://github.com/joseluisq/envoy-docker-registry/pulls) or [issue](https://github.com/joseluisq/envoy-docker-registry/issues).

## License
MIT license

© 2019 [Jose Quintana](https://git.io/joseluisq)
