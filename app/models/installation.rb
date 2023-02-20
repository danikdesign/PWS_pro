class Installation < ApplicationRecord
  belongs_to :client
  has_one :ticket

  validates :date, presence: true
  validates :pressure, presence: true
  validates :incoming_tds, presence: true
  validates :out_tds, presence: true
end
