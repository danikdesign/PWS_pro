class TicketDecorator < ApplicationDecorator
  delegate_all

  def formatted_datetime
    datetime.strftime('%a %d %b %Y %H:%M')
  end

  def client_name
    "#{ticketable.client.first_name} #{ticketable.client.last_name}"
  end

end
