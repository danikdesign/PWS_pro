# frozen_string_literal: true

class ServicePurifierPart < ApplicationRecord
  belongs_to :service
  belongs_to :purifier_part
end
