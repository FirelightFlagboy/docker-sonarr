# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM alpine:3.18 as builder

COPY --link pkg-info.json /pkg-info.json

ARG PKG_VERSION
ARG TARGETARCH

COPY --link in-docker-build.sh /build.sh

RUN sh /build.sh

FROM alpine:3.18

ARG PKG_VERSION

LABEL org.opencontainers.image.source="https://github.com/Sonarr/Sonarr"
LABEL org.opencontainers.image.description="Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available."
LABEL org.opencontainers.image.version=${PKG_VERSION}
LABEL org.opencontainers.image.title="Sonarr"

COPY --from=builder /opt/sonarr /opt/sonarr
RUN apk --no-cache add icu-libs sqlite-libs

USER 1234:1234

ENTRYPOINT [ "/opt/sonarr/Sonarr", "-nobrowser", "-data=/config" ]
