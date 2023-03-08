class Installation < ApplicationRecord
  include Ticketable
  belongs_to :client

  validates :date, presence: true
  validates :pressure, presence: true
  validates :in_tds, presence: true
  validates :out_tds, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["date"]
  end
end
