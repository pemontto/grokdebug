FROM ruby:2.6.3-alpine

ENV GROK_DIR=/opt/grokdebug
COPY . $GROK_DIR
ENV BUILD_PACKAGES="git make gcc musl-dev linux-headers"
WORKDIR $GROK_DIR

RUN apk update && apk add $BUILD_PACKAGES && \
	bundle install && \
 	apk del $BUILD_PACKAGES --purge

CMD ["rackup", "-o", "0.0.0.0", "-p", "80"]