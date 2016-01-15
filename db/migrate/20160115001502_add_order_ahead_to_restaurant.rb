class AddOrderAheadToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :order_ahead, :boolean, default: false
  end
end
