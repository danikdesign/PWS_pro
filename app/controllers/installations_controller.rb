class InstallationsController < ApplicationController
  before_action :set_client
  def new
    @installation = @client.installations.build
  end
  def create
    @installation = @client.installations.build installation_create_params

    if @installation.save
      redirect_to clients_path
    else
      render :new
    end
  end

  private

  def installation_create_params
    params.require(:installation).permit(:date, :pressure, :incoming_tds, :out_tds, :notes, :status)
  end

  def set_client
    @client = Client.find params[:client_id]
  end
end