class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
