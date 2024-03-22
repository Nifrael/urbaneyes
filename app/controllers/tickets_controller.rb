class TicketsController < ApplicationController
  before_action :find_ticket, only: %i[show edit update destroy]

  def index
    @tickets_damage = Ticket.where(category: "damage")
    @tickets_upgrade = Ticket.where(category: "upgrade")
    @tickets = Ticket.all
    @markers = @tickets.geocoded.map do |ticket|
      {
        lat: ticket.latitude,
        lng: ticket.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {ticket: ticket}),
        marker_html: render_to_string(partial: "markers", locals: {ticket: ticket})
      }
    end
    @user = current_user
    @unread_notifications = Notification.where(hub_id: current_user.hub.id, read: false) # A mettre dans controleur application
    @tickets_by_distance = distance_by_kilometers(@tickets)
  end

  def show
    @markers =
      [{
        lat: @ticket.latitude.to_f,
        lng: @ticket.longitude.to_f,
        info_window_html: render_to_string(partial: "info_window_show", locals: {ticket: @ticket}),
        marker_html: render_to_string(partial: "marker")
      }]
    @vote = Vote.new
    @comment = Comment.new
    @comments = Comment.where(ticket_id: params[:id])
  end

  def new
    @ticket = Ticket.new(category: params[:category])
    @tickets = Ticket.all
    @user = current_user.id
  end

  def create
    @ticket = Ticket.create(ticket_params)
    @ticket.user_id = current_user.id
    @ticket.status = 'pending'
    if @ticket.save
      redirect_to ticket_path(@ticket)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @ticket.update(ticket_params)
    redirect_to ticket_path(@ticket), notice: 'Ticket was successfully updated.'
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, status: :see_other
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :photo, :category, :description, :address, :status, :latitude, :longitude, :user_id)
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  def distance_by_kilometers(tickets)
    tickets.sort_by { |ticket| ticket.distance_to([current_user.latitude, current_user.longitude]) }
  end
end

#
#
# User.all.each do |user|
# @notification = @ticket.notifications.create(
#   hub_id: user.hub.id,
#   notifiable_id: @ticket.id
# )
