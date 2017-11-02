FROM nginx:stable-alpine

#ENV SOURCE_REF v-2017-03-13
ENV SOURCE_REF v-2017-10-31

COPY 001-musicbrainz /etc/nginx/conf.d/001-musicbrainz

# likely don't need '--recursive' on git clone
RUN apk update \
 && apk --no-cache add nodejs git \
 && git clone  https://github.com/metabrainz/musicbrainz-server.git musicbrainz-server \
 && cd musicbrainz-server \
 && git fetch --tags \
 && git checkout ${SOURCE_REF} \
 && rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf \
 && cp admin/nginx/mbserver-rewrites.conf /etc/nginx/ \
 && cp admin/nginx/nginx.conf /etc/nginx/ \
 && npm install --only=production \
 && echo Not cp lib/DBDefs.pm.sample DBDefs.pm \
 && echo Done
WORKDIR /musicbrainz-server
COPY DBDefs.js root/static/scripts/common/
RUN ./node_modules/.bin/gulp
# Or (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan json
# ./script/dbdefs_to_js.pl --client
# ./node_modules/.bin/gulp
# ./script/dbdefs_to_js.pl --client
#keep:
#/musicbrainz-server/root
# npm install https://github.com/metabrainz/musicbrainz-server.gitls -la
