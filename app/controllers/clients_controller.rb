class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
  def create
    @client = Client.new client_params

    if @client.save
      flash[:success] = 'The client has been added'
      redirect_to clients_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @q = Client.ransack params[:q]
    @clients = @q.result distinct: true
    @clients = @clients.decorate
  end

  def show
    @client = Client.find params[:id]
  end


  private
  def client_params
    params.require(:client).permit(:first_name,
                                   :last_name,
                                   :address,
                                   :phone,
                                   :purifier_brand,
                                   :purifier_stages,
                                   :purifier_tank,
                                   :purifier_pump)
  end
end
