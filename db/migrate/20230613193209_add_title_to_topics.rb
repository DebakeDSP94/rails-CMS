class AddTitleToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :title, :string
  end
end
