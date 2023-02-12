class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
  def create
    @client = Client.new client_params

    if @client.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def client_params
    params.require(:client).permit(:first_name,
                                   :last_name,
                                   :address,
                                   :phone,
                                   :purifier_brand,
                                   :purifier_stages,
                                   :putifier_pump,
                                   :purifier_tank)
  end
end
