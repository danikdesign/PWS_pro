# ---------- БАЗОВЫЙ ОБРАЗ ----------
FROM ruby:3.2.0-slim AS base

# Переменные окружения
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test"

# Устанавливаем системные зависимости
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Включаем corepack (современный способ установки Yarn)
RUN corepack enable

WORKDIR /app


# ---------- УСТАНОВКА ЗАВИСИМОСТЕЙ ----------
FROM base AS builder

# Копируем Gemfile и package.json для кэширования зависимостей
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v "$(grep -A1 "BUNDLED WITH" Gemfile.lock | tail -n1 | tr -d ' ')" || gem install bundler
RUN bundle install --jobs=4 --retry=3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Копируем весь проект
COPY . .

# Сборка ассетов
RUN yarn build && yarn build:css

# Прекомпилируем ассеты (Propshaft/JS/CSS)
RUN bundle exec rake assets:precompile


# ---------- ФИНАЛЬНЫЙ ОБРАЗ ----------
FROM base

WORKDIR /app

# Копируем зависимости из builder
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

# Открываем порт
EXPOSE 3000

# Команда запуска приложения
CMD rake db:migrate && bin/rails server -e production -b 0.0.0.0 -p ${PORT:-3000}