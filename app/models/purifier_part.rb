class PurifierPart < ApplicationRecord
    has_many :service_purifier_parts, dependent: :destroy
    has_many :questions, through: :service_purifier_parts
end
