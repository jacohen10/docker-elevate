class AddVerifiedToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :verification, :boolean, default: false
  end
end
