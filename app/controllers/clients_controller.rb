class ClientsController < ApplicationController
  before_action :set_client!, only: %i[edit update destroy]

  def new
    @client = Client.new  
  end

  def create
    @client = Client.new client_params

    if @client.save
      flash[:success] = t('.success')
      redirect_to client_path(@client)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit 
  end

  def update
    if @client.update client_params
      flash[:success] = t('.success')
      redirect_to client_path(@client)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t('.success')
        redirect_to clients_path, status: :see_other
      end
    end
  end

  def index
    @q = Client.ransack params[:q]
    @clients = @q.result.includes(:installations, :services)
    @clients = @clients.decorate
  end

  def show
    @client = Client.find params[:id]
    @client = @client.decorate
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

  def set_client!
    @client = Client.find params[:id]
  end

end
