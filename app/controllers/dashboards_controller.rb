class DashboardsController < ApplicationController

  def index
    @tickets_damage = Ticket.where(category: "damage").where(user_id: current_user)
    @tickets_upgrade = Ticket.where(category: "upgrade").where(user_id: current_user)
    @user = current_user
    @tickets = Ticket.where(user_id: current_user)
  end
end
