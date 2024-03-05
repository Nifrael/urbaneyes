class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
    @vote.ticket_id = params[:id]
    @vote.up_vote = params[:up_vote]
    @vote.save
  end

  private

  def vote_params
    params.require(:vote).permit(:ticket_id, :user_id, :up_vote)
  end
end
