FROM alpine:3.10

MAINTAINER David Stefan <stefda@gmail.com>

ENV OSM2PGSQL_VERSION 0.96.0

COPY target/testing /tmp/repo/testing
COPY user.abuild/*.rsa.pub /etc/apk/keys/

RUN echo "@custom /tmp/repo/testing" >> /etc/apk/repositories && \
    apk --no-cache update && \
    apk --no-cache add g++ make cmake openssl && \
    apk --no-cache add expat-dev bzip2-dev zlib-dev boost-dev postgresql-dev lua-dev && \
    apk add proj4-dev@custom && \
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