class DashboardsController < ApplicationController

  def index
    @user = current_user
    @tickets = Ticket.where(user_id: current_user)
  end
end
