class AddCommentToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :comment, :string
  end
end
