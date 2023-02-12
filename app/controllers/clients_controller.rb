class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
  def create
    @client = Client.new client_params

    if @client.save
      redirect_to clients_path
    else
      render :new
    end
  end

  def index
    @clients = Client.order(created_at: :desc)
  end


  private
  def client_params
    params.require(:client).permit(:first_name,
                                   :last_name,
                                   :address,
                                   :phone,
                                   :purifier_brand,
                                   :purifier_stages,
                                   :purifier_pump,
                                   :purifier_tank)
  end
end
