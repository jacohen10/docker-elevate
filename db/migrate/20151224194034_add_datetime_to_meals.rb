class AddDatetimeToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :order_ahead, :datetime
  end
end
