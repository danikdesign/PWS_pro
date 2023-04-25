# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_user!

  def index; end

  def services_calendar
    start_date = params.fetch(:start_date, Date.today).to_date
    @services = Service.where(
      status: false,
      date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
    )
  end
end
