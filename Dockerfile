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

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install --jobs=4

# Install JS packages
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy full project
COPY . .

# Precompile assets
ENV RAILS_ENV=production
RUN bundle exec rake assets:precompile

# ------------------------------
# Final runtime image
# ------------------------------
FROM ruby:3.2-alpine AS final

RUN apk add --no-cache \
  postgresql-client \
  nodejs \
  yarn \
  tzdata \
  imagemagick

WORKDIR /app

# Copy Ruby gems
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Copy application
COPY --from=builder /app /app

ENV RAILS_ENV=production
ENV RACK_ENV=production

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]