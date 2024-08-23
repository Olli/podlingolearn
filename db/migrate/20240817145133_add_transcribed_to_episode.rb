class AddTranscribedToEpisode < ActiveRecord::Migration[7.2]
  def change
    add_column :episodes, :transcribed_at, :datetime
  end
end
