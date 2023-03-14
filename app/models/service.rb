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

  def self.ransackable_attributes(auth_object = nil)
    ['date', 'client_id']
  end

end
