# frozen_string_literal: true

class ServiceCreator < ApplicationService
  def initialize(client)
    @client = client
  end

  def call(date)
    create_service(date)
  end

  protected

  def replacement_parts
    parts = PurifierPart.all

    first_service_parts = @client.purifier_stages == 4 ? parts[0..1] : parts[0..2]

    second_service_parts =

      case @client.purifier_stages
      when 4
        parts[0..3].reject { |p| p.id == 3 }
      when 5
        parts[0..3]
      when 6
        parts[0..4]
      when 7
        parts[0..5]
      end

    @replacement = if @client.services.size.even? || @client.services.empty?
                     first_service_parts.map(&:id)
                   else
                     second_service_parts.map(&:id)
                   end

    @replacement
  end

  def create_service(date)
    next_date = date + 182

    @client.services.create(date: next_date,
                            pressure: 0.0,
                            in_tds: 0,
                            out_tds_before: 0,
                            out_tds_after: 0,
                            status: false,
                            purifier_part_ids: replacement_parts)
  end
end
