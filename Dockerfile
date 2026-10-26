# syntax=docker/dockerfile:1
FROM dhi.io/nginx:1.30-alpine3.23-dev AS builder

RUN \
      grep -Eq '^[[:space:]]*location[[:space:]]+/[[:space:]]*\{' /etc/nginx/conf.d/default.conf \
      && sed -i '/^[[:space:]]*location[[:space:]]*\/[[:space:]]*{/a\        autoindex on;' \
        /etc/nginx/conf.d/default.conf

FROM dhi.io/nginx:1.30-alpine3.23

COPY --from=builder --chown=65532:65532 /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
  CMD ["busybox", "wget", "-q", "-O", "/dev/null", "http://127.0.0.1:8080/"]
