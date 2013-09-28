class Game < ActiveRecord::Base
   attr_accessible :dice1, :dice2, :dice3, :dice4, :dice5, :dice6, :D1_held, :D2_held, :D3_held, :D4_held, :D5_held,
                   :D6_held
end
