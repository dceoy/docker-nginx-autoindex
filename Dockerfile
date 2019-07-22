FROM alpine:latest

RUN set -e \
      && apk add --update --no-cache nginx

RUN set -e \
      && grep -n -e $'^[ \t]*location / {$' /etc/nginx/conf.d/default.conf \
        | cut -d : -f 1 \
        | xargs -i expr 1 + {} \
        | xargs -i sed -ie '{} s/return 404;$/autoindex on;/' /etc/nginx/conf.d/default.conf \
      && sed -ie '/# Everything is a 404/d' /etc/nginx/conf.d/default.conf \
      && rm -f /etc/nginx/conf.d/default.confe

RUN set -e \
      && mkdir /run/nginx \
      && ln -sf /dev/stdout /var/log/nginx/access.log \
      && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
