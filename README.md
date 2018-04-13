docker-nginx-autoindex
======================

Dockerfile for Nginx with autoindex

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/nginx-autoindex/)

```sh
$ docker pull dceoy/nginx-autoindex
```

Usage
-----

Run a web server to serve the current directory at `/` of Nginx

```sh
$ docker container run --rm -p 80:80 -v ${PWD}:/var/www/html:ro dceoy/nginx-autoindex
```

Run a web server with docker-compose

```sh
$ docker-compose -f /path/to/docker-nginx-autoindex/docker-compose.yml up
```
