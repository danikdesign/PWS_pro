module Ticketable
  extend ActiveSupport::Concern

  included do
    has_many :tickets, as: :ticketable, dependent: :destroy
  end
end
