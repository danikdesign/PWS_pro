class InstallationsController < ApplicationController

  def new
  end
  def create
    @installation = @client.installations.build :installation_create_params
  end

  private

  def installation_create_params
    params.require(:installation).permit(:date, :pressure, :incoming_tds, :out_tds, :notes, :status)
  end
end