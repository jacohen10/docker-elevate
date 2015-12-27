class ChangeVerificationColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :customers, :verification, nil
  end
end
