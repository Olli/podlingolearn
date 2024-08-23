class AddSomethingToEpisode < ActiveRecord::Migration[7.2]
  def change
    add_column :episodes, :title, :string
    add_column :episodes, :content, :string
    add_column :episodes, :author, :string
    add_column :episodes, :published, :datetime
  end
end
