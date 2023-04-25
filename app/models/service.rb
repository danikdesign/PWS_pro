# frozen_string_literal: true

class Service < ApplicationRecord
  include Ticketable
  belongs_to :client
  has_many :service_purifier_parts, dependent: :destroy
  has_many :purifier_parts, through: :service_purifier_parts

  validates :date, presence: true
  validates :pressure, presence: true
  validates :in_tds, presence: true
  validates :out_tds_before, presence: true
  validates :out_tds_after, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[date client_id]
  end

  def self.in_date_range(start_date, end_date)
    where(date: start_date..end_date, status: false)
  end

  def self.in_a_week
    today = Date.today
    in_a_week = today + 7
    where(date: today..in_a_week, status: false)
  end
end
