# frozen_string_literal: true

class PurifierPart < ApplicationRecord
  has_many :service_purifier_parts, dependent: :destroy
  has_many :services, through: :service_purifier_parts
end
