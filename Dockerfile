FROM ruby:3.2.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

WORKDIR /key_value_store

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN gem install bundler && bundle install

COPY . .

EXPOSE 6378

CMD ["ruby" "server/server.rb"]

