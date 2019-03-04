build:
	-docker build -t envoy-docker-registry:latest -f Dockerfile .
.PHONY: build