require_relative '../../telegram/bot.rb'

class BotReminder
  include Sidekiq::Worker
  
  def perform
    puts 'REMIND...'
    bot = GreatTelegramBot.new(ENV['TELEGRAM_BOT_TOKEN'])
    bot.reminder
  end
end