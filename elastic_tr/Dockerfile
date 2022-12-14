FROM docker.elastic.co/elasticsearch/elasticsearch:7.16.0

MAINTAINER Artur Jewula <zefiryn@jewula.net>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN bin/elasticsearch-plugin install analysis-phonetic
RUN bin/elasticsearch-plugin install analysis-icu