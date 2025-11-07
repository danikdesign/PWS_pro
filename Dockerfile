# ---------- Базовый слой ----------
FROM ruby:3.2.0 AS base

# Обновляем систему и устанавливаем зависимости для Rails, Node и Yarn
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential libpq-dev nodejs npm git curl && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем Yarn напрямую (надёжнее, чем corepack)
RUN npm install -g yarn

WORKDIR /app

# ---------- Билдер ----------
FROM base AS builder

# Устанавливаем зависимости Ruby
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs=4 --retry=3

# Устанавливаем JS зависимости
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Копируем весь код приложения
COPY . .

# Предкомпиляция ассетов (если используется sprockets / webpacker / jsbundling)
RUN bundle exec rails assets:precompile

# ---------- Финальный слой ----------
FROM base AS final

WORKDIR /app

# Копируем только необходимые файлы из билда
COPY --from=builder /app /app

# Устанавливаем переменные окружения
ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

# Порт, который слушает Rails
EXPOSE 3000

# Команда по умолчанию
CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec puma -C config/puma.rb"]