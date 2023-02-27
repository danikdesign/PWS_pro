class Installation < ApplicationRecord
  include Ticketable
  belongs_to :client

  validates :date, presence: true
  validates :pressure, presence: true
  validates :incoming_tds, presence: true
  validates :out_tds, presence: true
end
