class TicketDecorator < ApplicationDecorator
  delegate_all

  def formatted_datetime
    datetime.strftime('%a %d %b %Y %H:%M')
  end

  def client_name
    "#{ticketable.client.first_name} #{ticketable.client.last_name}"
  end

  def purifier
    if ticketable.client.purifier_pump
      "#{ticketable.client.purifier_brand} RO#{ticketable.client.purifier_stages}P"
    else
      "#{ticketable.client.purifier_brand} RO#{ticketable.client.purifier_stages}"
    end
  end

end
