FROM alpine:3.6

MAINTAINER David Stefan <stefda@gmail.com>

RUN apk --no-cache update && \
    apk --no-cache add g++ make cmake openssl

# add osm2pgsql dependencies
RUN apk --no-cache add expat-dev bzip2-dev zlib-dev boost-dev postgresql-dev lua-dev

# add proj4 dependency from edge/testing repo
RUN apk add proj4-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing

# install osm2pgsql
ENV OSM2PGSQL_VERSION 0.94.0

RUN wget https://github.com/openstreetmap/osm2pgsql/archive/${OSM2PGSQL_VERSION}.tar.gz && \
    tar xzvf ${OSM2PGSQL_VERSION}.tar.gz && \
    cd /osm2pgsql-${OSM2PGSQL_VERSION} && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install

# purge packages that are no longer needed
RUN apk del expat-dev bzip2-dev zlib-dev boost-dev g++ make openssl
