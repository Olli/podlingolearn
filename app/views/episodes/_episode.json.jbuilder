json.extract! episode, :id, :podcast_id, :url, :is_youtube, :created_at, :updated_at
json.url episode_url(episode, format: :json)
