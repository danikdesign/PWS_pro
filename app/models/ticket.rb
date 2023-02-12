class Ticket < ApplicationRecord
  belongs_to :installation
  belongs_to :service
end
