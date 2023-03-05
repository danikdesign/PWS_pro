class Service < ApplicationRecord
  include Ticketable
  belongs_to :client

  validates :date, presence: true
  validates :replaced, presence: true
  validates :pressure, presence: true
  validates :incoming_tds, presence: true
  validates :out_tds_before, presence: true
  validates :out_tds_after, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["date"]
  end

end
