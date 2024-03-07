class TicketsController < ApplicationController
  before_action :find_ticket, only: %i[show edit update destroy]

  def index
    @tickets = Ticket.all
  end

  def show
    @vote = Vote.new
    @comment = Comment.new
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.create(ticket_params)
    @ticket.user_id = current_user.id
    if ticket.save
      redirect_to ticket_path(@ticket)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @ticket.update
    redirect_to ticket_path(@ticket)
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, status: :see_other
  end

  private

  def ticket_params
    params.require(:ticket).permit(:photo, :type, :description, :address, :status, :latitude, :longitude, :user_id)
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end
end
