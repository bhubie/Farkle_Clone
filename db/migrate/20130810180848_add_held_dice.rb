class AddHeldDice < ActiveRecord::Migration
  def change
    add_column :games, :D1_held, :boolean, :default => false
    add_column :games, :D2_held, :boolean, :default => false
    add_column :games, :D3_held, :boolean, :default => false
    add_column :games, :D4_held, :boolean, :default => false
    add_column :games, :D5_held, :boolean, :default => false
    add_column :games, :D6_held, :boolean, :default => false
  end
end
