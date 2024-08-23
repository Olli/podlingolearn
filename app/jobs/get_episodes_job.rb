
class GetEpisodesJob < ApplicationJob
  queue_as :fetch
  def perform(episodes,download_again = false)
    #PodcastActions::Sync.sync_episodes(episodes)
  end
end
