require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'

token = '6218601166:AAFgMbEksJwJjN-f6Aoiout4PdSL3-N2_C8'

Telegram::Bot::Client.run(token, environment: :test) do |bot|
  bot.listen do |message|
    p message
    return
  end
end
