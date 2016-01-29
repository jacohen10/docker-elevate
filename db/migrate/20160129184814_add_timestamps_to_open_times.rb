class AddTimestampsToOpenTimes < ActiveRecord::Migration
  def change
    add_column :open_times, :created_at, :datetime
    add_column :open_times, :updated_at, :datetime
  end
end
