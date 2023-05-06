web: rake db:migrate && RAILS_ENV=production bin/rails server -b 0.0.0.0 -p ${PORT:-3000}
js: yarn build --watch
css: yarn build:css --watch
telegram: ruby telegram/bot.rb