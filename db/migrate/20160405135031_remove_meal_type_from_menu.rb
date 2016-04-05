class RemoveMealTypeFromMenu < ActiveRecord::Migration
  def change
    remove_column :menus, :meal_type, :string
  end
end
