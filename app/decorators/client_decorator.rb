# frozen_string_literal: true

class ClientDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    created_at.strftime('%Y-%m-%d')
  end

  def name
    "#{first_name} #{last_name}"
  end

end

