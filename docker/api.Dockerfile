FROM ruby:2.4.1
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

ENV APP_HOME=/app \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD . $APP_HOME