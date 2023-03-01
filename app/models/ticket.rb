class Ticket < ApplicationRecord
  belongs_to :ticketable, polymorphic: true

  validates :datetime, presence: true
end
