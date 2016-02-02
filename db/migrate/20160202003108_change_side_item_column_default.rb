class ChangeSideItemColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :sides, :side_item, "none"
  end
end
