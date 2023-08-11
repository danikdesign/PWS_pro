# frozen_string_literal: true

class InstallationsController < ApplicationController
  before_action :require_user!
  before_action :set_client!
  before_action :set_installation!, only: %i[edit update update_from_ticket destroy]

  def new
    @installation = @client.installations.build
  end

  def create
    @installation = @client.installations.build installation_create_params

    if @installation.save
      if @installation.status
        ServiceCreator.new(@installation.client).call(@installation.date)
      end
      flash[:success] = t('.success')
      redirect_to client_path(@client)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @installation.update installation_update_params
      if @installation.status
        ServiceCreator.new(@installation.client).call(@installation.date)
        @installation.tickets.last.destroy if @installation.tickets.last.present?
        redirect_to tickets_path
        flash[:success] = t('.from_ticket')
      else
        redirect_to client_path(@client)
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # todo
  # def update_from_ticket
  #   if @installation.update installation_update_params
  #     if @installation.status
  #       ServiceCreator.new(@installation.client).call(@installation.date)
  #       @installation.tickets.last.destroy
  #       redirect_to tickets_path
  #       flash[:success] = t('.from_ticket')
  #     else
  #       redirect_to client_path(@client)
  #     end
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  private

  def installation_create_params
    params.require(:installation).permit(:date,
                                         :pressure,
                                         :in_tds,
                                         :out_tds,
                                         :notes,
                                         :status)
  end

  def installation_update_params
    params.require(:installation).permit(:date,
                                         :pressure,
                                         :in_tds,
                                         :out_tds,
                                         :notes,
                                         :status)
  end

  def set_client!
    @client = Client.find params[:client_id]
    @client.decorate
  end

  def set_installation!
    @installation = @client.installations.find params[:id]
    @insallation = @installation.decorate
  end
end
