class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.ticket_id = params[:ticket_id]
    if @comment.save
      create_notification
      redirect_to ticket_path(id: @comment.ticket.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to ticket_path, status: :see_other
  end

  private

  def create_notification
    if @comment.ticket.user_id != current_user.id
      @notification = @comment.notifications.create(
        hub_id: @comment.ticket.user.hub.id,
        notifiable_id: @comment.id
      )
      HubChannel.broadcast_to(
        @notification.hub,
        # user_first_name: @comment.user.first_name,
        # user_last_name: @comment.user.last_name,
        # ticket_title: @comment.ticket.title,
        # ticket_id: @comment.ticket.id,
        # created_at: @notification.created_at,
        unread_notification: 1
        # notifiable_type: @notification.notifiable_type
      )
    end
  end

  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :content)
  end
end
