class CreateEpisodes < ActiveRecord::Migration[7.2]
  def change
    create_table :episodes do |t|
      t.integer :podcast_id
      t.text :url
      t.boolean :is_youtube

      t.timestamps
    end
    add_index :episodes, :url, unique: true
  end
end
