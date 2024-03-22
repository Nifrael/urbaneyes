class HubsController < ApplicationController
  after_action :update_notifications, only: [:index]

  def index
    @hub = current_user.hub
    @notifications = Notification.where(hub_id: current_user.hub.id, read: false)
  end

  private

  def update_notifications
    @notifications.update_all(read: true)
  end
end
