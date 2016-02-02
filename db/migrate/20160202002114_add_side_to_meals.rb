class AddSideToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :side, :string
  end
end
