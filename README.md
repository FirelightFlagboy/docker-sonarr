# Docker Sonarr

Provide a simple docker image for [`sonarr`].

[`sonarr`]: https://github.com/Sonarr/Sonarr

The goal is to provide a simpler docker image that don't package a bootstrap script like [`linuxserver/sonarr`] to be used on `docker-compose` & `k8s`.

[`linuxserver/sonarr`]: https://github.com/linuxserver/docker-sonarr

The image is provided at <https://hub.docker.com/r/firelightflagbot/sonarr>

## Quick start

Here is a simple `docker-compose` file:

```yaml
services:
  sonarr:
    image: firelightflagbot/sonarr:4.0.0.688
    user: 1234:1234 # This is the default uid/gid, you can change it.
    ports:
      - 8989:8989
    volumes:
      - type: bind
        source: /somewhere/sonarr-config # The folder need to be owned by the set'd user in `services.sonarr.user` (sonarr need to be able to write to it).
        target: /config
```
