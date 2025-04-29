class Episode < ApplicationRecord
  belongs_to :podcast
  has_one_attached :audio_file
  has_one_attached :subtitle_file

  validates_uniqueness_of :url, scope: [ :podcast_id ]
end
