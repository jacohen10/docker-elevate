class AddInRestaurantPaymentToRestaurant < ActiveRecord::Migration
  def change
        add_column :restaurants, :in_restaurant_payment, :boolean, default: true
  end
end
