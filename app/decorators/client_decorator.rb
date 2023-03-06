# frozen_string_literal: true

class ClientDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    created_at.strftime('%Y-%m-%d')
  end

  def name
    "#{first_name} #{last_name}"
  end

  def purifier
    if purifier_pump
      "#{purifier_brand} RO#{purifier_stages}P"
    else
      "#{purifier_brand} RO#{purifier_stages}"
    end
  end

end

