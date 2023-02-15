class Client < ApplicationRecord
  has_many :installations
  has_many :services

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :address, presence: true, length: { minimum: 4 }
  validates :phone, presence: true, length: { minimum: 6 }
end
