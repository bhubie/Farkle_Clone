class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :p1_score
      t.boolean :player1, :default => true
      t.integer :p2_score
      t.boolean :player2, :default => false
      t.integer :dice1
      t.integer :dice2
      t.integer :dice3
      t.integer :dice4
      t.integer :dice5
      t.integer :dice6

      t.timestamps
    end
  end
end
