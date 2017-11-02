FROM openjdk:jdk-alpine

WORKDIR /home/search

RUN curl -o /home/search/index.jar ftp://ftp.eu.metabrainz.org/pub/musicbrainz/search/index/index.jar

VOLUME ["/home/search/data"]

CMD java -jar /home/search/index.jar --db-host ${DB_PORT_5432_TCP_ADDR} --db-name musicbrainz_db --db-user musicbrainz --db-password musicbrainz
