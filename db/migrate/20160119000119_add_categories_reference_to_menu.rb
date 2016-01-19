class AddCategoriesReferenceToMenu < ActiveRecord::Migration
  def change
    add_reference :menus, :category, index: true, foreign_key: true
  end
end
