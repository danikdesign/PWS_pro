# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)
require 'telegram/bot'

class GreatTelegramBot
  include HTTParty

  def initialize(token)
    @token = token
  end

  def run
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        if !User.exists?(telegram_id: message.from.id)
          bot.api.send_message(chat_id: message.chat.id, text: "Вибачте, але не можу знайти вас в системі :(")
        else
          case message
          when Telegram::Bot::Types::CallbackQuery
            case message.data
            when '/week'
              bot.api.send_message(chat_id: message.from.id, text: "#{week_services}\n#{Time.now}")
            when '/month'
              bot.api.send_message(chat_id: message.from.id, text: "#{month_services}\n#{Time.now}")
            end
          when Telegram::Bot::Types::Message
            kb = [[
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Обслуговування на тиждень', callback_data: '/week'),
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Обслуговування на місяць', callback_data: '/month')
            ]]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: "Привіт #{message.from.first_name}!", reply_markup: markup)
          end
        end
      end
    end
  end

  def reminder
    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/sendMessage?chat_id=#{ENV['DANIK_CHAT']}&text=#{week_services}")
  end

  private

  def week_services
    num = 0
    services =
      if Service.in_a_week.present?
        Service.in_a_week.map do |service|
          num += 1
          client = Client.find(service.client_id)
          name = "#{client.first_name} #{client.last_name}"
    
          "#{num}. Дата: #{service.date}\n#{name}\n\n"
        end
      else
        ['Цього тижня немає обслуговувань']
      end
    
      services.join
  end

  def month_services
    num = 0
    services =
      if Service.in_a_month.present?
        Service.in_a_month.map do |service|
          num += 1
          client = Client.find(service.client_id)
          name = "#{client.first_name} #{client.last_name}"
    
          "#{num}. Дата: #{service.date}\n#{name}\n\n"
        end
      else
        ['Цього місяця немає обслуговувань']
      end
    
      services.join
  end

end

