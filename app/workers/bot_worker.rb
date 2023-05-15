require_relative '../../telegram/bot.rb'

class BotWorker
  include Sidekiq::Worker

  def perform
    puts 'Starting bot...'
    bot = GreatTelegramBot.new(ENV['TELEGRAM_BOT_TOKEN'])
    bot.run
  end
end