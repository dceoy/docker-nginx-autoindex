FROM alpine:latest

RUN set -e \
      && apk add --update --no-cache nginx

RUN set -eo pipefail \
      && grep -n -e $'^[ \t]*location / {$' /etc/nginx/http.d/default.conf \
        | cut -d : -f 1 \
        | xargs -i expr 1 + {} \
        | xargs -i sed -ie '{} s/return 404;$/autoindex on;/' /etc/nginx/http.d/default.conf \
      && sed -ie '/# Everything is a 404/d' /etc/nginx/http.d/default.conf \
      && rm -f /etc/nginx/http.d/default.confe

RUN set -e \
      && ln -sf /dev/stdout /var/log/nginx/access.log \
      && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
