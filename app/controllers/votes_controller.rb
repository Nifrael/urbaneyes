class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Vote.vote_by_user(params[:ticket_id], current_user.id, params[:up_vote] == 'true')
      redirect_to ticket_path(params[:ticket_id]), notice: 'Votre vote a été enregistré.'
    else
      redirect_to ticket_path(params[:ticket_id]), alert: "Votre vote n’a pas pu être enregistré."
    end
  end
end
