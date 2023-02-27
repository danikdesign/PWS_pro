class Ticket < ApplicationRecord
  belongs_to :ticketable, polymorphic: true
end
