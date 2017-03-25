#!/bin/sh

cd /home/search

java -jar /home/search/index.jar --db-host ${DB_PORT_5432_TCP_ADDR} --db-name musicbrainz_db --db-user musicbrainz --db-password musicbrainz
