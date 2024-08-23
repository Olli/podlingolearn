require 'open-uri'

namespace :sync do
  task feeds: [:environment] do
    Podcast.all.each do |podcast|
      PodcastActions::Sync.sync_podcast(podcast)
    end
  end
end
