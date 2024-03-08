class VotesController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   @vote = Vote.new(vote_params)
  #   @vote.user_id = current_user.id
  #   @vote.ticket_id = params[:id]
  #   @vote.up_vote = params[:up_vote]
  #   @vote.save
  # end

  def create
    Vote.vote_by_user(params[:ticket_id], current_user.id, params[:up_vote] == 'true')
    redirect_to ticket_path(params[:ticket_id]), notice: 'Votre vote a été enregistré.'
  end

  # private

  # def vote_params
  #   params.require(:vote).permit(:ticket_id, :user_id, :up_vote)
  # end
end
