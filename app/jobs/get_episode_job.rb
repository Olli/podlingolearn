
class GetEpisodeJob < ApplicationJob
  queue_as :fetch
  def perform(episode, download_again = false)
    PodcastActions::Sync.download_episode(episode)
  end
end
