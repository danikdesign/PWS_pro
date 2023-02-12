class Client < ApplicationRecord
  has_many :installations
  has_many :services
end
