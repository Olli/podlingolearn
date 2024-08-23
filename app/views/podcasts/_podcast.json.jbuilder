json.extract! podcast, :id, :name, :url, :xml_url, :active, :has_youtube, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
