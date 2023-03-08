# frozen_string_literal: true

class ServiceCreator < ApplicationService
  def initialize(client, purifier_parts)
    @client = client
    @parts = purifier_parts
  end

  def call(date)
    service = create_service(date)

    service
  end

  protected

  def create_service(date)

    if @client.services.size.odd? || @client.services.size == 0
      @replacement = @parts[0..2]
    else
      @replacement = @parts[0..3]
    end

    next_date = date + 182
    @client.services.create(date: next_date,
                            pressure: 0.0,
                            in_tds: 0,
                            out_tds_before: 0,
                            out_tds_after: 0,
                            status: false,
                            purifier_parts: @replacement)
  end
end
