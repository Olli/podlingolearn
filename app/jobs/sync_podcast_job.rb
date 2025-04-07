class SyncPodcastJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    PodcastActions::Sync.sync_podcast(podcast)
  end

  # Sends a Turbo Stream update to the "sync-link" target with the result text
  def after_perform(podcast)
    Turbo::StreamsChannel.broadcast_update_to("sync-link", {
      result: "Sync successful!" })
  end
end
