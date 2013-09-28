class AddDefaultToPlayersScore < ActiveRecord::Migration
  def change
    change_column_default(:games, :p1_score, 0)
    change_column_default(:games, :p2_score, 0)
  end
end
