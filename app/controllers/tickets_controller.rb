class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
    @markers = @tickets.geocoded.map do |ticket|
      {
        lat: ticket.latitude,
        lng: ticket.longitude
      }
    end
  end
end
