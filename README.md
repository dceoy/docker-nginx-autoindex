docker-nginx-autoindex
======================

Dockerfile for Nginx with autoindex

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/nginx/)

```sh
$ docker pull dceoy/nginx-autoindex
```

Run a container and make home directory available at `/` of Nginx

```sh
$ docker run -p 80:80 -v ${HOME}:/var/www/html -d dceoy/nginx-autoindex
$ chmod 755 ${HOME}
```
