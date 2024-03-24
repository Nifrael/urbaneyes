class HubChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    hub = Hub.find(params[:id])
    stream_for hub
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
