FROM ruby:alpine
MAINTAINER B. van Wetten <bas@vanwetten.com>

ENV DOCKER_TRAVIS_CLI=0.1.0

RUN apk add --no-cache build-base git && \
    gem install travis && \
    gem install travis-lint && \
    apk del build-base && \
    mkdir travis

WORKDIR travis

VOLUME ["/travis"]

ENTRYPOINT ["travis"]