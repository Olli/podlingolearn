class SyncPodcastJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    PodcastActions::Sync.sync_podcast(podcast)
  end
end
