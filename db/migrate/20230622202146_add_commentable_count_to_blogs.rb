class AddCommentableCountToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :commentable_count, :integer
  end
end
