FROM ubuntu:latest

RUN set -e \
      && apt-get -y update \
      && apt-get -y upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests nginx \
      && apt-get -y autoremove \
      && apt-get clean

RUN set -e \
      && grep -n -e '^[^#].*location / {$' /etc/nginx/sites-available/default \
        | cut -f 1 -d : \
        | xargs expr 1 + \
        | xargs -I {} sed -ie '{}i \\tautoindex on;' /etc/nginx/sites-available/default

RUN set -e \
      && ln -sf /dev/stdout /var/log/nginx/access.log \
      && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
