class AddTempScore < ActiveRecord::Migration
  def up
    add_column :games, :temp_score, :integer, :default => 0
  end

  def down
  end
end
