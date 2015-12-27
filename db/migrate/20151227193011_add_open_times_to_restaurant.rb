class AddOpenTimesToRestaurant < ActiveRecord::Migration
  def change
    create_table :open_times do |t|
      t.string :day
      t.time :opening
      t.time :closing
      t.references :restaurant, index: true, foreign_key: true
    end
  end
end
