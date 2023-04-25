# frozen_string_literal: true

class Installation < ApplicationRecord
  include Ticketable
  belongs_to :client

  validates :date, presence: true
  validates :pressure, presence: true
  validates :in_tds, presence: true
  validates :out_tds, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    ['date']
  end
end
