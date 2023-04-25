require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'
require 'rufus-scheduler'
require 'date'

scheduler = Rufus::Scheduler.new

token = ENV['TELEGRAM_BOT_TOKEN']
chat_id = ENV['D_CHAT_ID']

def week_services
  num = 0
  services = 
    if Service.in_a_week.present?
      Service.in_a_week.map do |service|
        num += 1
        client = Client.find(service.client_id)
        name = "#{client.first_name} #{client.last_name}"
    
        "#{num}. Date: #{service.date}\n#{name}\n\n"
      end
    else
      ["No service this week"]
    end

  services.join
end

Telegram::Bot::Client.run(token) do |bot|
  
  scheduler.cron '0 12 * * 1 Europe/Kiev' do
    bot.api.send_message(chat_id: chat_id, text: "#{week_services}")
  end

  
  bot.listen do |message|

    if !User.exists?(telegram_id: message.from.id)
      bot.api.send_message(chat_id: message.chat.id, text: "Sorry, but I can't find you in the system :(")
    else
      case message
      when Telegram::Bot::Types::CallbackQuery
        if message.data == 'services'
          bot.api.send_message(chat_id: message.from.id, text: "#{week_services} #{Time.now}")
        end
      when Telegram::Bot::Types::Message
        kb = [[
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Show', callback_data: 'services'),
        ]]
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
        bot.api.send_message(chat_id: message.chat.id, text: 'Services in a week', reply_markup: markup)
      end
    end
  end
end