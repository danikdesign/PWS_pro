class Service < ApplicationRecord
  belongs_to :client
  has_one :ticket
end
