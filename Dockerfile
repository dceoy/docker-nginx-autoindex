# syntax=docker/dockerfile:1
ARG ALPINE_VERSION=3
FROM alpine:${ALPINE_VERSION}

ARG UID=101
ARG GID=101

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

RUN \
    addgroup -S -g "${GID}" nginx \
    && adduser -S -H -h /nonexistent -g 'nginx user' -s /bin/false -G nginx -u "${UID}" -D nginx

# hadolint ignore=DL3018
RUN \
      --mount=type=cache,target=/var/cache/apk,sharing=locked \
      apk add --update --no-cache curl nginx

# hadolint ignore=SC3003
RUN \
      grep -n -e $'^[ \t]*location / {$' /etc/nginx/http.d/default.conf \
        | cut -d : -f 1 \
        | xargs -I{} expr 1 + {} \
        | xargs -I{} sed -ie '{} s/return 404;$/autoindex on;/' /etc/nginx/http.d/default.conf \
      && sed -ie '/# Everything is a 404/d' /etc/nginx/http.d/default.conf \
      && sed -ie 's/^user /# user /' /etc/nginx/nginx.conf \
      && rm -f /etc/nginx/http.d/default.confe /etc/nginx/nginx.confe

RUN \
      ln -sf /dev/stdout /var/log/nginx/access.log \
      && ln -sf /dev/stderr /var/log/nginx/error.log

USER nginx

EXPOSE 80

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
