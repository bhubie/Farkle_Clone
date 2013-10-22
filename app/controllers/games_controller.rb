class GamesController < ApplicationController
 
  #GET new Game
  def index
    
  end
  def new
    @game = Game.new
  end
  
  #POST New Game
  def create
      @game = Game.new(params[:game])
          if @game.save
            render :edit
          else
            render :new
          end
  end
  
  #GET Game
  def edit
    @game = Game.find(params[:id])
  end
  
  #PUT Game
  def update
    @game = Game.find(params[:id])
    
     #checks to see if the value passed by the submit button was to roll the dice, or to end the turn
     case 
     when params[:commit] == 'Roll Dice'
          
          (@game)
          render :edit
          
     when params[:commit] == 'End Turn'
          end_turn(@game)
          render :edit
          
     when end_game(@game) == true
        if @game.player1 == true
          flash[:success] = "Congratulations Player 1, you are the winnder"
        else
          flash[:success] = "Congratulations Player 2, you are the winnder"
        end
       
       redirect_to :root
     end
  end
  
 ###################################
 ## Additional controller methods ##
 ## For Turn Logic                ##
 ## try and move somewhere else?  ##
 ###################################
   $turn_count = 1
 
      
 def turn(x)
      #roll dice for 6 turns then switch
    if $turn_count <= 6
      if x.update_attributes(params[:game])
        if x.D1_held == false
            x.update_attribute(:dice1, roll_dice)
        end
        
        if x.D2_held == false
            x.update_attribute(:dice2, roll_dice)
        end
        
        if x.D3_held == false
            x.update_attribute(:dice3, roll_dice)
        end
        
        if x.D4_held == false
            x.update_attribute(:dice4, roll_dice)
        end
        
        if x.D5_held == false
            x.update_attribute(:dice5, roll_dice)
        end
        
        if x.D6_held == false
            x.update_attribute(:dice6, roll_dice)
        end
        
        $turn_count += 1
        scoring(x)
        
      end
   else 
     #if turn is up switch turn to the next player & update score
     #checks to see if it is player 1's turn. if not, it will switch it to be
      end_turn(x)
   end 
  end
  
  def rolls_left
    return $turn_count
  end
  
  def roll_dice
      dice = Random.new 
      dice.rand(1..6) 
  end
  
  def turn_count_reset
    $turn_count = 1
  end
  
  def end_turn(x)
     #if turn is up switch turn to the next player & update score
     #checks to see if it is player 1's turn. if not, it will switch it to be
    if x.player1 == true
      x.update_attribute(:player1, false)
      x.update_attribute(:player2, true)
      current_score = x.p1_score
      temp1_score = x.temp_score
      x.update_attribute(:p1_score, current_score+temp1_score)
      reset_dice(x)
      turn_count_reset
    else
      x.update_attribute(:player2, false)
      x.update_attribute(:player1, true)
      current_score = x.p2_score
      temp2_score = x.temp_score
      x.update_attribute(:p2_score, current_score+temp2_score)
      reset_dice(x)
      turn_count_reset
    end
  end
  
  def reset_dice(x)
    #reset dice and dice_held in the database
    x.update_attribute(:dice1, nil)
    x.update_attribute(:dice2, nil)
    x.update_attribute(:dice3, nil)
    x.update_attribute(:dice4, nil)
    x.update_attribute(:dice5, nil)
    x.update_attribute(:dice6, nil)
    x.update_attribute(:D1_held, false)
    x.update_attribute(:D2_held, false)
    x.update_attribute(:D3_held, false)
    x.update_attribute(:D4_held, false)
    x.update_attribute(:D5_held, false)
    x.update_attribute(:D6_held, false)
    x.update_attribute(:temp_score, 0)
  end
  
  def scoring(x)
    #each 1 = 100
    #each 5 = 50
    #three 1's = 1000
    #three 2's = 200
    #three 3's = 300
    #three 4's = 400
    #three 5's = 500
    #three 6's = 600
    
    round_score = x.temp_score
    #declare scoring buckets for the dice values
    score_1 = 0
    score_2 = 0
    score_3 = 0
    score_4 = 0
    score_5 = 0
    score_6 = 0
    
    
    dice_values = Array.new  
   dice_values.push(x.dice1)
   dice_values.push(x.dice2)
   dice_values.push(x.dice3)
   dice_values.push(x.dice4)
   dice_values.push(x.dice5)
   dice_values.push(x.dice6)
   

    
    #check to see if count of dice of 3, 4, and 6's = pass scoring criteria
    
    if dice_values.count(2) >= 3
      score_2 = 200
    end
    if dice_values.count(3) >= 3
      score_3 = 300
    end
    if dice_values.count(4) >= 3
      score_4 = 400
    end
    if dice_values.count(6) >= 3
      score_6 = 600
    end
  
    
    #check to see if dice values of 5 = scoring criteria
    if dice_values.count(5) == 3
      score_5 = 500
    elsif dice_values.count(5) == 4
      score_5 = 550
    elsif dice_values.count(5) == 5
      score_5 = 600
    elsif dice_values.count(5) == 6
      score_5 = 1000
    elsif dice_values.count(5) == 2
      score_5 = 100
    elsif dice_values.count(5) == 1
      score_5 = 50
    else
      score_5 = 0
    end
    
    #checks to see if dice values of 1 = scoring criteria
    if dice_values.count(1) == 1
      score_1 = 100
    elsif dice_values.count(1) == 2
      score_1 = 200
    elsif dice_values.count(1) == 3
      score_1 = 1000
    elsif dice_values.count(1) == 4
      score_1 = 1100
    elsif dice_values.count(1) == 5
      score_1 = 1200
    elsif dice_values.count(1) == 6
      score_1 = 2000
    else
      score_1 = 0
    end
    
    roll_score = score_1 + score_2 + score_3 + score_4 + score_5 + score_6
    
    if roll_score == 0
      flash.now[:notice] = "No score, next players turn!"
      end_turn(x)
    else
    x.update_attribute(:temp_score, roll_score)
    end
  end
  

  
  def end_game(x)
    #End game method that checks to see if score is greater than 10000
    if x.p1_score >= 10000
      return true
    
    elsif x.p2_score >= 10000
      return true 
    else
      return false
    end
    
  end
end
