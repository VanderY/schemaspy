FROM openjdk:17-alpine3.14

ENV LC_ALL=C

ARG GIT_BRANCH=local
ARG GIT_REVISION=local

ENV POSTGRESQL_VERSION=42.3.8

LABEL POSTGRESQL_VERSION=$POSTGRESQL_VERSION

LABEL GIT_BRANCH=$GIT_BRANCH
LABEL GIT_REVISION=$GIT_REVISION

ADD docker/open-sans.tar.gz /usr/share/fonts/

RUN adduser java -h / -D && \
    set -x && \
    apk add --no-cache curl unzip graphviz fontconfig && \
    fc-cache -fv && \
    mkdir /drivers_inc && \
    cd /drivers_inc && \
    curl -JLO https://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/$POSTGRESQL_VERSION/postgresql-$POSTGRESQL_VERSION.jar && \
    chown -R java /drivers_inc && \
    apk del curl


ADD target/schema*-app.jar /usr/local/lib/schemaspy/
ADD docker/schemaspy.sh /usr/local/bin/schemaspy

USER java
WORKDIR /

ENV SCHEMASPY_DRIVERS=/drivers
ENV SCHEMASPY_OUTPUT=/builds/devops/fastlane-react-native-test/schemaconfig

ENTRYPOINT ["/usr/local/bin/schemaspy"]
