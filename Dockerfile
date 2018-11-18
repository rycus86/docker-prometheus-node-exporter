FROM alpine AS builder

LABEL maintainer "Viktor Adam <rycus86@gmail.com>"

ARG ARCH=amd64
ARG VERSION=0.17.0-rc.0

RUN apk --no-cache add wget ca-certificates \
    && mkdir -p /tmp/install \
    && wget -O /tmp/install/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-$ARCH.tar.gz \
    && cd /tmp/install \
    && tar --strip-components=1 -xzf node_exporter.tar.gz

FROM scratch

COPY --from=builder /tmp/install/node_exporter /bin/

EXPOSE     9100
ENTRYPOINT [ "/bin/node_exporter" ]
