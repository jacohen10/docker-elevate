class ChangeVerificationColumnToString < ActiveRecord::Migration
  def change
    change_column :customers, :verification, :string
  end
end
