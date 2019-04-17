FROM ruby:2.5-alpine

ENV BUILD_PACKAGES curl-dev ruby-dev build-base

# Update and install base packages
RUN apk update && apk upgrade && apk add bash $BUILD_PACKAGES

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN rm -rf /var/cache/apk/*

EXPOSE 8080/tcp

CMD ["./main.rb"]
