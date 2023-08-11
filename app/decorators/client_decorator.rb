# frozen_string_literal: true

class ClientDecorator < ApplicationDecorator
  delegate_all
  decorates_association :installations, with: InstallationDecorator
  decorates_association :services, with: ServiceDecorator

  def to_partial_path
    'clients/client'
  end

  def formatted_created_at
    l created_at, format: :long
  end

  def name
    "#{first_name} #{last_name}"
  end

  def formatted_date
    l date
  end

  def purifier
    if purifier_pump
      "#{purifier_brand} RO#{purifier_stages}P"
    else
      "#{purifier_brand} RO#{purifier_stages}"
    end
  end
end
