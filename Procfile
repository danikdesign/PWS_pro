web: rake db:migrate && bin/rails server -b 0.0.0.0 -p ${PORT:-3000}
js: yarn build --watch
css: yarn build:css --watch
sidekiq: bundle exec sidekiq -q default
telegram: ruby telegram/bot.rb