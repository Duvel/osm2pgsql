FROM alpine:3.6

MAINTAINER David Stefan <stefda@gmail.com>

ENV OSM2PGSQL_VERSION 0.94.0

RUN apk --no-cache update && \
    apk --no-cache add g++ make cmake openssl && \
    apk --no-cache add expat-dev bzip2-dev zlib-dev boost-dev postgresql-dev lua-dev && \
    apk add proj4-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing && \
    wget https://github.com/openstreetmap/osm2pgsql/archive/${OSM2PGSQL_VERSION}.tar.gz && \
    tar xzvf ${OSM2PGSQL_VERSION}.tar.gz && \
    cd /osm2pgsql-${OSM2PGSQL_VERSION} && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd / && \
    rm -r /osm2pgsql-${OSM2PGSQL_VERSION} && \
    apk del expat-dev bzip2-dev zlib-dev boost-dev g++ make openssl