# ---------- Базовый слой ----------
FROM ruby:3.2.0 AS base

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    curl gnupg build-essential libpq-dev postgresql-client git && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

FROM base AS builder

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs=4 --retry=3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

RUN bundle exec rails assets:precompile

FROM base AS final
WORKDIR /app
COPY --from=builder /app /app

ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec puma -C config/puma.rb"]