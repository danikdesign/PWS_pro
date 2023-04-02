class ServiceDecorator < ApplicationDecorator
  delegate_all
  decorates_association :tickets, with: TicketDecorator

  def formatted_date
    l date
  end
end