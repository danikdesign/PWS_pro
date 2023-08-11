# frozen_string_literal: true

class InstallationDecorator < ApplicationDecorator
  delegate_all
  decorates_association :tickets, with: TicketDecorator

  def to_partial_path
    'installations/installation_details'
  end

  def formatted_date
    l date
  end
end
