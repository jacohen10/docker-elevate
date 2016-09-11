class AddAvailableToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :available, :boolean, default: true
  end
end
