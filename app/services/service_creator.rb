# frozen_string_literal: true

class ServiceCreator < ApplicationService
  def initialize(client)
    @client = client
  end

  def call(date)
    service = create_service(date)

    service
  end

  protected

  def create_service(date)
    next_date = date + 182
    @client.services.create(date: next_date,
                            replaced: '---',
                            pressure: 0.0,
                            incoming_tds: 0,
                            out_tds_before: 0,
                            out_tds_after: 0,
                            status: false)
  end
end
