# Envoy / Docker Registry

> [Envoy / Alpine x86_64](https://www.docker.com/) and [Docker Registry x86_64](https://hub.docker.com/_/registry) image.

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

```yml
version: "3.3"

services:
  docker-registry:
    restart: unless-stopped
    image: joseluisq/envoy-docker-registry:latest
    environment:
      - REGISTRY_HTTP_ADDR=0.0.0.0:5000
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

## Contributions

Feel free to send some [Pull request](https://github.com/joseluisq/envoy-docker-registry/pulls) or [issue](https://github.com/joseluisq/envoy-docker-registry/issues).

## License
MIT license

© 2019 [Jose Quintana](https://git.io/joseluisq)