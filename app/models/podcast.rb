class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 450, 450 ]
  end
end
