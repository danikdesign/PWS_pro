# ---------- Базовый слой ----------
FROM ruby:3.2.0 AS base

# Устанавливаем зависимости для Rails + Node + Yarn
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    curl gnupg build-essential libpq-dev git && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# ---------- Билдер ----------
FROM base AS builder

# Устанавливаем Ruby зависимости
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs=4 --retry=3

# Устанавливаем JS зависимости
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Копируем весь код
COPY . .

# Предкомпиляция ассетов
RUN bundle exec rails assets:precompile

# ---------- Финальный слой ----------
FROM base AS final

WORKDIR /app

COPY --from=builder /app /app

ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec puma -C config/puma.rb"]