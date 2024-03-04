class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.ticket_id = params[:id]
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :content)
  end
end
