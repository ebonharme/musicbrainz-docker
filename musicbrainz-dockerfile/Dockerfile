FROM ubuntu:xenial

#ENV SOURCE_REF v-2017-03-13
ENV SOURCE_REF v-2017-10-31
RUN (echo "deb http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse" > /etc/apt/sources.list && echo "deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list && echo "deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list && echo "deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list)
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git-core postgresql
RUN apt-get install -y \
    memcached \
    build-essential \
    libxml2-dev libpq-dev \
    libexpat1-dev \
    libdb-dev \
    libicu-dev \
    liblocal-lib-perl \
    cpanminus \
    cron \
    nginx

RUN git clone --recursive https://github.com/metabrainz/musicbrainz-server.git musicbrainz-server && \
    cd musicbrainz-server && \
    git checkout ${SOURCE_REF}

RUN cat /musicbrainz-server/Makefile.PL | grep ^requires > cpanfile
RUN cpanm --installdeps --notest .
RUN cpanm --notest Plack::Middleware::Debug::Base \
    Catalyst::Plugin::Cache::HTTP \
    Catalyst::Plugin::StackTrace \
    Cache::Memcached::Fast \
    JSON::Any Cache::Memory \
    Digest::MD5::File \
    Term::Size::Any \
    LWP::Protocol::https \
    Starlet \
    Plack::Handler::Starlet \
    Starlet::Server \
    Server::Starter \
    TURNSTEP/DBD-Pg-3.4.2.tar.gz

COPY DBDefs.pm /musicbrainz-server/lib/
COPY scripts/start.sh /start.sh
COPY scripts/crons.conf /crons.conf
COPY scripts/replication.sh /replication.sh
COPY scripts/createdb.sh /createdb.sh
COPY scripts/recreatedb.sh /recreatedb.sh
COPY scripts/set-token.sh /set-token.sh

RUN crontab /crons.conf

WORKDIR /musicbrainz-server
EXPOSE 55901
CMD ["/start.sh"]
