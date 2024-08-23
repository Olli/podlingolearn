class Episode < ApplicationRecord
  belongs_to :podcast
  has_one_attached :audio_file
  has_one_attached :srt_file
end
