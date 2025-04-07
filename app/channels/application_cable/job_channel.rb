class JobChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sync-link"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
