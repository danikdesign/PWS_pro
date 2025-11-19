# ------------------------------
# Base image
# ------------------------------
FROM ruby:3.2-alpine AS base

# Install needed build dependencies
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
# Install gems
# ------------------------------
FROM base AS builder

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test --deployment

# ------------------------------
# Install JS deps
# ------------------------------
COPY package.json yarn.lock ./
RUN yarn install --production

# ------------------------------
# Copy application code
# ------------------------------
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# ------------------------------
# Final minimal image
# ------------------------------
FROM ruby:3.2-alpine

RUN apk add --no-cache \
  postgresql-client \
  nodejs \
  yarn \
  tzdata \
  imagemagick

WORKDIR /app

# Copy bundles and app
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

ENV RAILS_ENV=production
ENV RACK_ENV=production

# The command Dokku will run
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]