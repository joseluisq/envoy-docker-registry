FROM envoyproxy/envoy-alpine:36f39c746eb7d03b762099b206403935b11972d8

LABEL maintainer=https://git.io/joseluisq

RUN set -ex \
    && apk update && apk add --no-cache bash ca-certificates apache2-utils curl \
    && curl -o registry https://raw.githubusercontent.com/docker/distribution-library-image/master/amd64/registry

RUN mv registry /bin/registry
COPY ./config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod u+x /bin/registry \
    && chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
