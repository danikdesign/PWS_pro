# frozen_string_literal: true

class TicketsController < ApplicationController

  before_action :set_ticketable!
  before_action :set_client

  def new
    @ticket = @ticketable.tickets.build
  end
  def create
    @ticket = @ticketable.tickets.build ticket_params

    if @ticket.save
      respond_to do |format|
        format.html do
          flash[:success] = "Ticket has been created"
          redirect_to client_path(@client)
        end

        #format.turbo_stream do
        #  flash.now[:success] = "Ticket has been created"
        #end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:datetime, :notes)
  end
  def set_ticketable!
    klass = [Installation, Service].detect {|c| params["#{c.name.underscore}_id"]}

    raise ActiveRecord::RecordNotFound if klass.blank?

    @ticketable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def set_client
    @client = Client.find(@ticketable.client_id)
  end
end
