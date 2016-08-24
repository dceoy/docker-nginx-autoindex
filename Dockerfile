FROM ubuntu

RUN set -e \
      && apt-get -y update \
      && apt-get -y upgrade \
      && apt-get -y install nginx \
      && apt-get clean

RUN set -e \
      && grep -n -e '^[^#].*location / {$' /etc/nginx/sites-available/default \
        | cut -f 1 -d : \
        | xargs expr 1 + \
        | xargs -I {} sed -ie '{}i \\tautoindex on;' /etc/nginx/sites-available/default

EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
