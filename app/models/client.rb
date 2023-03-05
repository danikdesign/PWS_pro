class Client < ApplicationRecord
  has_many :installations, dependent: :destroy
  has_many :services, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :address, presence: true, length: { minimum: 4 }
  validates :phone, presence: true, length: { minimum: 6 }

  def self.ransackable_attributes(auth_object = nil)
    ["id",
     "first_name",
     "address",
     "phone",
     "purifier_brand",
     "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["installations", "services"]
  end
end
