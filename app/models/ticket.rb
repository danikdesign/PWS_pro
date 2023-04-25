# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :ticketable, polymorphic: true

  validates :datetime, presence: true
end
