class AddCommentToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :comment, :string
  end
end
