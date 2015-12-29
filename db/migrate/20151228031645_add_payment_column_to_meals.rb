class AddPaymentColumnToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :payment, :boolean, default: false
  end
end
