class CreateSides < ActiveRecord::Migration
  def change
    create_table :sides do |t|
      t.string :side_item
      t.string :details
      t.references :category, index: true, foreign_key: true
    end
  end
end
