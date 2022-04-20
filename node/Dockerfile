FROM ubuntu:20.04

RUN apt-get update && apt-get -y install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

ENV LANGUAGE en_US
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install wget curl git vim openssh-server htop sudo rsyslog logrotate software-properties-common \
  nodejs npm rsync nginx
RUN npm install -g yarn

ADD ./run-server.sh /run-server.sh

EXPOSE 22 3000

CMD bash -x /run-server.sh
