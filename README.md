docker-nginx-autoindex
======================

Dockerfile for Nginx with autoindex

[![CI](https://github.com/dceoy/docker-nginx-autoindex/actions/workflows/ci.yml/badge.svg)](https://github.com/dceoy/docker-nginx-autoindex/actions/workflows/ci.yml)

Docker image
------------

Builds on Docker Hardened Nginx 1.30 for Alpine 3.23. Authenticate to the free
Docker Hardened Images registry before local builds:

```sh
docker login dhi.io
```

The runtime listens on container port 8080 under its built-in non-root user.
Map host port 80 to container port 8080 if desired.


Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/nginx-autoindex/)

```sh
$ docker image pull dceoy/nginx-autoindex
```

Usage
-----

Run a web server to serve the current directory at `/` of Nginx

```sh
$ docker container run --rm -p 80:8080 -v ${PWD}:/usr/share/nginx/html:ro dceoy/nginx-autoindex
```

Run a web server with docker-compose

```sh
$ docker compose -f /path/to/docker-nginx-autoindex/compose.yml up
```
