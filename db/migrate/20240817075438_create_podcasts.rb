class CreatePodcasts < ActiveRecord::Migration[7.2]
  def change
    create_table :podcasts do |t|
      t.string :name
      t.text :url
      t.text :xml_url
      t.boolean :active
      t.boolean :has_youtube

      t.timestamps
    end
    add_index :podcasts, :url, unique: true
    add_index :podcasts, :xml_url, unique: true
  end
end
