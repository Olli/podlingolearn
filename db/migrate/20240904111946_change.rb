class Change < ActiveRecord::Migration[7.2]
  def change
    change_column :episodes, :content, :text
  end
end
