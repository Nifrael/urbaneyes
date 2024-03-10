class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.ticket_id = params[:ticket_id]
    if @comment.save
      redirect_to ticket_path(id: @comment.ticket.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :content)
  end
end
