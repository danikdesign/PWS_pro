require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'
require_relative 'week_services.rb'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

token = ENV['TELEGRAM_BOT_TOKEN']

def week_services
  num = 0
  services = 
    Service.in_a_week.map do |service|
      num += 1
      client = Client.find(service.client_id)
      name = "#{client.first_name} #{client.last_name}"
  
      "#{num}. Date: #{service.date}\n#{name}\n\n"
    end

  services.join
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

    if !User.exists?(telegram_id: message.from.id)
      bot.api.send_message(chat_id: message.chat.id, text: "Sorry, but I can't find you in the system :(")
    else
      case message.text
      when '/start'
        question = 'Выберите интересующий вас пункт меню:'

        menu =
          Telegram::Bot::Types::ReplyKeyboardMarkup.new(
            keyboard: [
              [{ text: 'Обслуживания на ближайшую неделю' }, { text: 'B' }],
              [{ text: 'C' }, { text: '/stop' }]
            ],
            one_time_keyboard: true
          )
        bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: menu)
      when 'Обслуживания на ближайшую неделю'
        menu =
        Telegram::Bot::Types::ReplyKeyboardMarkup.new(
          keyboard: [
            [{ text: 'Обслуживания на ближайшую неделю' }, { text: 'B' }],
            [{ text: 'C' }, { text: '/stop' }]
          ],
          one_time_keyboard: true
        )

        bot.api.send_message(chat_id: message.chat.id, text: "#{week_services}", reply_markup: menu)
      when 'B'
        kb = [[
          Telegram::Bot::Types::KeyboardButton.new(text: 'Give me your phone number', request_contact: true),
          Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)
        ]]
        markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
        bot.api.send_message(chat_id: message.chat.id, text: 'Hey!', reply_markup: markup)
      when '/stop'
        # See more: https://core.telegram.org/bots/api#replykeyboardremove
        kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
        bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(', reply_markup: kb)
      end
    end
  end
end
