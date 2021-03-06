#!/bin/sh

set -e

case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@" ;;
esac

exec "$@" &
/usr/local/bin/envoy -c /etc/envoy-service.yaml --service-cluster ${SERVICE_NAME}
