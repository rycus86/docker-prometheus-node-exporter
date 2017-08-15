# Prometheus node exporter on ARM

This project produces [Node exporter](https://github.com/prometheus/node_exporter)
Docker images for [Prometheus](https://prometheus.io) on *ARM* hosts.

The available tags are:

- `armhf`: for *32-bits ARM* hosts (built on [Travis](https://travis-ci.org/rycus86/docker-prometheus-node-exporter))  
  [![Layers](https://images.microbadger.com/badges/image/rycus86/prometheus-node-exporter:armhf.svg)](https://microbadger.com/images/rycus86/prometheus-node-exporter:armhf "Get your own image badge on microbadger.com")
- `aarch64`: for *64-bits ARM* hosts (also built on Travis)  
  [![Layers](https://images.microbadger.com/badges/image/rycus86/prometheus-node-exporter:aarch64.svg)](https://microbadger.com/images/rycus86/prometheus-node-exporter:aarch64 "Get your own image badge on microbadger.com")

The images are all based on *Alpine Linux* with the *ARM* images having a
small *QEMU* binary to be able to build them on *x64* hosts.

## Usage

The image uses a similar startup command to the offical
[prom/node-exporter](https://hub.docker.com/r/prom/node-exporter/) image's.
To run it, use:

```shell
docker run -d -p 9100:9100 \
  -v "/proc:/host/proc:ro" \
  -v "/sys:/host/sys:ro" \
  -v "/:/rootfs:ro" \
  --net="host" \
  rycus86/prometheus-node-exporter:aarch64 \
    --collector.procfs /host/proc \
    --collector.sysfs /host/sys \
    --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
```

This will start the exporter on port *9100* on *64-bits ARM* hosts.
