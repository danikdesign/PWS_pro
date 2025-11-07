# ---------- 1. Base image ----------
FROM ruby:3.2.0 AS base

# Устанавливаем системные зависимости
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential nodejs yarn postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Создаём рабочую директорию
WORKDIR /app

# ---------- 2. Dependencies ----------
# Копируем только Gemfile и Gemfile.lock — для кеширования bundle install
COPY Gemfile Gemfile.lock ./

# Устанавливаем Bundler и гемы
RUN gem install bundler -v 2.5.11 && \
    bundle config set without 'development test' && \
    bundle install --jobs 4 --retry 3

# ---------- 3. Build stage ----------
FROM base AS builder

# Копируем весь проект
COPY . .

# Устанавливаем JS-зависимости
RUN yarn install --check-files

# Сборка JS и CSS
RUN yarn build && yarn build:css

# Прекомпиляция ассетов
RUN RAILS_ENV=production SECRET_KEY_BASE=dummy bin/rails assets:precompile

# ---------- 4. Final image ----------
FROM base

WORKDIR /app

# Копируем собранный код из builder
COPY --from=builder /app /app

# Настройки окружения
ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV PORT=3000

# Открываем порт
EXPOSE 3000

# Основная команда запуска
CMD ["bash", "-c", "rake db:migrate && bin/rails server -b 0.0.0.0 -p ${PORT}"]