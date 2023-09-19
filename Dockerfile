FROM ruby:3.2.2

WORKDIR /app

RUN gem install bundler
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
