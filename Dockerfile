FROM ruby:2.5
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn

WORKDIR /sousaku
COPY Gemfile Gemfile.lock /sousaku/
RUN bundle install