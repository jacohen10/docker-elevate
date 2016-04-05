class AddLastNameToCustomer < ActiveRecord::Migration
  def change
    rename_column :customers, :name, :first_name
    add_column :customers, :last_name, :string
  end
end
