FROM ruby:2.6.3-alpine

ENV GROK_DIR=/opt/grokdebug
COPY . $GROK_DIR
ENV BUILD_PACKAGES="git make gcc musl-dev linux-headers"
WORKDIR $GROK_DIR

RUN apk update && apk add $BUILD_PACKAGES && \
	sed -i 's/gem '"'"'haml'"'"'/gem '"'"'haml'"'"', '"'"'4.0.7'"'"'/g' Gemfile && \
 	gem update && \
 	gem install json -v '2.1.0' && \
 	gem install raindrops -v '0.19.0' && \
 	gem install haml -v '~>4.0.0' && \
 	bundle update && \
 	apk del $BUILD_PACKAGES --purge

CMD ["rackup", "-o", "0.0.0.0", "-p", "80"]