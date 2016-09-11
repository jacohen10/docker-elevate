class AddCookTimeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :cook_time, :integer, default: 20
  end
end
