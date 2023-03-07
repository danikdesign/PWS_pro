# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_client!
  before_action :set_service!, only: %i[edit update destroy]
  before_action :purifier_parts, only: %i[new create edit update]

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
          flash.now[:success] = "New service has been added"
        end
      end

    else
      render :new, status: :unprocessable_entity
    end
  end
   
  def edit
  end

  def update
      if @service.update service_update_params
        respond_to do |format|
          format.html do
            flash[:success] = "The service has been updated"
            redirect_to client_path(@client)
          end
  
          format.turbo_stream do
            flash.now[:success] = "The service has been updated"
          end
        end

      else
        render :edit, status: :unprocessable_entity
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
                                    :notes,
                                    :status)
  end

  def service_update_params
    params.require(:service).permit(:date,
                                    :replaced,
                                    :pressure,
                                    :incoming_tds,
                                    :out_tds_before,
                                    :out_tds_after,
                                    :notes)
  end

  def set_client!
    @client = Client.find params[:client_id]
  end

  def set_service!  
    @service = @client.services.find params[:id]
  end

  def purifier_parts 
    @purifier_parts = PurifierPart.all
  end
end
