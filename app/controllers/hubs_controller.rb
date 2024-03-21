class HubsController < ApplicationController
  def index
    @hub = current_user.hub
    @notifications = Notification.where(hub_id: current_user.hub.id)
  end
end
