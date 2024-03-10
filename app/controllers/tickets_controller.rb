class TicketsController < ApplicationController
  before_action :find_ticket, only: %i[show edit update destroy]

  def index
    @tickets = Ticket.all
    @markers = @tickets.geocoded.map do |ticket|
      {
        lat: ticket.latitude,
        lng: ticket.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {ticket: ticket}),
        marker_html: render_to_string(partial: "marker", locals: {ticket: ticket})
      }
    end
  end

  def show
    @vote = Vote.new
    @comment = Comment.new
    @comments = Comment.where(ticket_id: params[:id])
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
