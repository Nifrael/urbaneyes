class DashboardsController < ApplicationController

  def index
    @tickets_damage = Ticket.where(category: "damage").where(user_id: current_user)
    @tickets_upgrade = Ticket.where(category: "upgrade").where(user_id: current_user)
    @user = current_user
    @tickets = Ticket.where(user_id: current_user)
    @users = User.all
  end

  def change_role
    @user = User.find(params[:id])
    new_role = params[:new_role].to_i
    new_role = new_role == 1 ? :admin : :user

    if @user.update(role: new_role)
      flash[:notice] = "Le rôle de l'utilisateur a été mis à jour avec succès."
    else
      flash[:alert] = "Erreur lors de la mise à jour du rôle de l'utilisateur."
    end

    redirect_back(fallback_location: root_path)
  end
end
