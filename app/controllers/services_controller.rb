# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_client
  def new
    @service = @client.services.build
  end
  def create
    @service = @client.services.build service_create_params

    if @service.save
      respond_to do |format|
        format.html do
          flash[:success] = "New service has been added"
          redirect_to clients_path
        end

        format.turbo_stream do
          flash.now[:success] = "Water purifier has been added"
        end
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def service_create_params
    params.require(:service).permit(:date,
                                    :replaced,
                                    :pressure,
                                    :incoming_tds,
                                    :out_tds_before,
                                    :out_tds_after,
                                    :next_date,
                                    :notes,
                                    :status)
  end

  def set_client
    @client = Client.find params[:client_id]
  end
end
