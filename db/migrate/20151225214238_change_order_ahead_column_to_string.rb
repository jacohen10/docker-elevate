class ChangeOrderAheadColumnToString < ActiveRecord::Migration
  def change
    change_column :meals, :order_ahead, :string
  end
end
