FROM ubuntu:14.04

MAINTAINER He Jun <junh@alauda.io>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

ENV REDIS_TRIB_PARA='10.171.129.10:7000 10.171.128.37:7000 10.172.230.213:7000 10.171.88.35:7000 10.44.25.231:7000 10.171.20.222:7000'

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Initial update and install of dependency that can add apt-repos
RUN apt-get -y update && apt-get install -y software-properties-common python-software-properties

# Add global apt repos
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise universe" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" && \
    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse"
RUN apt-get update && apt-get -y upgrade

# Install system dependencies
RUN apt-get install -y gcc make g++ build-essential libc6-dev tcl git supervisor ruby

# Must be installed seperate from ruby or it will complain about broken package
RUN apt-get install -y rubygems

# Install ruby dependencies so we can bootstrap the cluster via redis-trib.rb
RUN gem install redis

# checkout the 3.0.6 tag (Will change to 3.2 tag when it is released as stable)
RUN git clone -b 3.0.7 https://github.com/antirez/redis.git

# Build redis from source
RUN (cd /redis && make)

RUN mkdir /redis-data && \
    mkdir /redis-data/7000 

# Add config files 
ADD ./docker-data/redis-conf /redis-conf

# Add supervisord configuration
ADD ./docker-data/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add startup script
ADD ./docker-data/start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 7000 

CMD ["/bin/bash", "/start.sh"]

