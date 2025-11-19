# ------------------------------
# Base image
# ------------------------------
FROM ruby:3.2-alpine AS base

RUN apk add --no-cache \
  build-base \
  linux-headers \
  git \
  postgresql-dev \
  nodejs \
  yarn \
  tzdata \
  imagemagick

WORKDIR /app

# ------------------------------
# Builder — install gems + JS
# ------------------------------
FROM base AS builder

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test --deployment

COPY package.json yarn.lock ./
RUN yarn install --production

# Copy the entire project
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# ------------------------------
# Final minimal runtime image
# ------------------------------
FROM ruby:3.2.0

RUN apk add --no-cache \
  postgresql-client \
  nodejs \
  yarn \
  tzdata \
  imagemagick

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

ENV RAILS_ENV=production
ENV RACK_ENV=production

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]