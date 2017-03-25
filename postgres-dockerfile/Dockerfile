FROM postgres:9.5
MAINTAINER jeffsturgis@gmail.com

ARG DEBIAN_FRONTEND="noninteractive"

# Update the Ubuntu and PostgreSQL repository indexes
RUN apt-get update && \
    apt-get -y -q install \
    git-core \
    build-essential \
    libxml2-dev \
    libpq-dev \
    libexpat1-dev \
    libdb-dev \
    libicu-dev \
    postgresql-server-dev-9.5 \
 && git clone https://github.com/metabrainz/postgresql-musicbrainz-unaccent.git /tmp/postgresql-musicbrainz-unaccent  \
 && git clone https://github.com/metabrainz/postgresql-musicbrainz-collate.git /tmp/postgresql-musicbrainz-collate \
 && cd /tmp/postgresql-musicbrainz-unaccent && make && make install \
 && cd /tmp/postgresql-musicbrainz-collate  && make && make install \
 && rm -R /tmp/* \
 && apt-get remove -y git-core build-essential \
 && apt-get autoremove -y \
 && ldd /usr/lib/postgresql/9.5/lib/musicbrainz_unaccent.so \
 && ldd /usr/lib/postgresql/9.5/lib/musicbrainz_collate.so \
 && echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf

 VOLUME  ["/media/dbdump"]
