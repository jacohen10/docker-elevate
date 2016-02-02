class AddRestaurantReferenceToSide < ActiveRecord::Migration
  def change
    add_reference :sides, :restaurant, index: true, foreign_key: true
  end
end
