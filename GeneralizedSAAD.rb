module Saad
  class Coordinated
    def self.specify_measurements(a, b, c, d, e, f)
      @player_mechanic        = a
      @player_attribute       = b
    
      @gribatomaton_mechanic  = c
      @gribatomaton_attribute = d

      @enemy_mechanic         = e
      @enemy_attribute        = f
    end
  
    def self.starting_stats
      #        04     06     07     09     10
      # 04  04,04  04,06  04,07  04,07  04,10
      # 06  06,04  06,06  06,07  06,07  06,10
      # 07  07,04  07,06  07,07  07,09  07,10
      # 09  09,04  09,06  09,07  09,09  09,10
      # 10  10,04  10,06  10,07  10,09  10,10

      starting_prediction = [
        [[ 0.4,  0.4], [ 0.4, 0.6], [ 0.4, 0.7], [ 0.4, 0.9], [ 0.4, 0.10]],
        [[ 0.6,  0.4], [ 0.6, 0.6], [ 0.6, 0.7], [ 0.6, 0.9], [ 0.6, 0.10]],
        [[ 0.7,  0.4], [ 0.7, 0.6], [ 0.7, 0.7], [ 0.7, 0.9], [ 0.7, 0.10]],
        [[ 0.9,  0.4], [ 0.9, 0.6], [ 0.9, 0.7], [ 0.9, 0.9], [ 0.9, 0.10]],
        [[ 0.10, 0.4], [0.10, 0.6], [0.10, 0.7], [0.10, 0.9], [0.10, 0.10]],
      ], [
        [[ 0.4,  0.4], [ 0.4, 0.6], [ 0.4, 0.7], [ 0.4, 0.9], [ 0.4, 0.10]],
        [[ 0.6,  0.4], [ 0.6, 0.6], [ 0.6, 0.7], [ 0.6, 0.9], [ 0.6, 0.10]],
        [[ 0.7,  0.4], [ 0.7, 0.6], [ 0.7, 0.7], [ 0.7, 0.9], [ 0.7, 0.10]],
        [[ 0.9,  0.4], [ 0.9, 0.6], [ 0.9, 0.7], [ 0.9, 0.9], [ 0.9, 0.10]],
        [[ 0.10, 0.4], [0.10, 0.6], [0.10, 0.7], [0.10, 0.9], [0.10, 0.10]],
      ], [
        [[ 0.4,  0.4], [ 0.4, 0.6], [ 0.4, 0.7], [ 0.4, 0.9], [ 0.4, 0.10]],
        [[ 0.6,  0.4], [ 0.6, 0.6], [ 0.6, 0.7], [ 0.6, 0.9], [ 0.6, 0.10]],
        [[ 0.7,  0.4], [ 0.7, 0.6], [ 0.7, 0.7], [ 0.7, 0.9], [ 0.7, 0.10]],
        [[ 0.9,  0.4], [ 0.9, 0.6], [ 0.9, 0.7], [ 0.9, 0.9], [ 0.9, 0.10]],
        [[ 0.10, 0.4], [0.10, 0.6], [0.10, 0.7], [0.10, 0.9], [0.10, 0.10]],
      ]

      ## Determines player starting hp
      player_row_options = [0, 1, 2, 3, 4]
      player_col_options = [0, 1, 2, 3, 4]
      player_arr_options = [0, 1]

      p_crow = player_row_options.sample
      p_ccol = player_col_options.sample
      p_carr = player_arr_options.sample

      @player_prediction = starting_prediction[0][p_crow][p_ccol][p_carr]

      ## Determines gribatomaton's starting hp
      gribatomaton_row_options = [0, 1, 2, 3, 4]
      gribatomaton_col_options = [0, 1, 2, 3, 4]
      gribatomaton_arr_options = [0, 1]

      g_crow = gribatomaton_row_options.sample
      g_ccol = gribatomaton_col_options.sample
      g_carr = gribatomaton_arr_options.sample

      @gribatomaton_prediction = starting_prediction[1][g_crow][g_ccol][g_carr]

      ## Determines enemy starting hp
      enemy_row_options = [0, 1, 2, 3, 4]
      enemy_col_options = [0, 1, 2, 3, 4]
      enemy_arr_options = [0, 1]

      e_crow = enemy_row_options.sample
      e_ccol = enemy_col_options.sample
      e_carr = enemy_arr_options.sample

      @enemy_prediction = starting_prediction[2][e_crow][e_ccol][e_carr]
    end
  
    def self.evaluate_player
      require "SelfModifiedDecisionTree"

      attribute = ["Player"]
    
      training = [
        [0.0010,    "Some #{@player_attribute} #{@player_mechanic}"],
        [0.2505,    "Mild #{@player_attribute} #{@player_mechanic}"],
        [0.5000,  "Medium #{@player_attribute} #{@player_mechanic}"],
        [0.7495,    "High #{@player_attribute} #{@player_mechanic}"],
        [0.9990,     "Max #{@player_attribute} #{@player_mechanic}"],
      ]

      dec_tree_configurations =    DecisionTree::ID3Tree.new(attribute, training, 1, :continuous)

      current_dectree1 = dec_tree_configurations
      current_dectree1.train

      test1 = [@player_prediction, "Medium #{@player_attribute}"]

      @decision = current_dectree1.predict(test1)

      puts "Predicted: #{@decision}"

      #@net_outcome1 = "Predicted: #{@decision}"
    end
  
    def self.evaluate_gribatomaton
      require "SelfModifiedDecisionTree"
    
      attribute = ["Gribatomaton"]
    
      training = [
        [0.0010,    "Some #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.2505,    "Mild #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.5000,  "Medium #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.7495,    "High #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.9990,     "Max #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
      ]

      dec_tree_configurations =    DecisionTree::ID3Tree.new(attribute, training, 1, :continuous)

      current_dectree1 = dec_tree_configurations
      current_dectree1.train

      test1 = [@gribatomaton_prediction, "Medium #{@gribatomaton_attribute}"]

      @decision = current_dectree1.predict(test1)

      puts "Predicted: #{@decision}"

      #@net_outcome2 = "Predicted: #{@decision}"
    end
  
    def self.evaluate_enemy
      require "SelfModifiedDecisionTree"
    
      attribute = ["Enemy"]
    
      training = [
        [0.0010,    "Some #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.2505,    "Mild #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.5000,  "Medium #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.7495,    "High #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.9990,     "Max #{@enemy_attribute} #{@enemy_mechanic}"],
      ]

      dec_tree_configurations =    DecisionTree::ID3Tree.new(attribute, training, 1, :continuous)

      current_dectree1 = dec_tree_configurations
      current_dectree1.train

      test1 = [@enemy_prediction, "Medium #{@enemy_attribute}"]

      @decision = current_dectree1.predict(test1)

      puts "Predicted: #{@decision}"

      #@net_outcome3 = "Predicted: #{@decision}"
    end
  
    def self.mechanic_prediction
      matrix = [
        [[@player_mechanic,       @player_mechanic], [@player_mechanic,       @gribatomaton_mechanic], [@player_mechanic,       @enemy_mechanic]],
        [[@gribatomaton_mechanic, @player_mechanic], [@gribatomaton_mechanic, @gribatomaton_mechanic], [@gribatomaton_mechanic, @enemy_mechanic]],
        [[@enemy_mechanic,        @player_mechanic], [@enemy_mechanic,        @gribatomaton_mechanic], [@enemy_mechanic,        @enemy_mechanic]],
      ], [
        [[0.5, 0.5], [0.5, 0.5], [0.5, 0.5]],
        [[0.5, 0.5], [0.5, 0.5], [0.5, 0.5]],
        [[0.5, 0.5], [0.5, 0.5], [0.5, 0.5]],
      ]

      row_probability = 0.33
      col_probability = 0.33

      selection_probability = row_probability * col_probability
 
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1]
      
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      dice_roll = matrix[0][cur_row][cur_col][cur_arr], matrix[1][cur_row][cur_col][cur_arr]
  
      d1 = dice_roll[0]
      d2 = dice_roll[1]

      puts "[#{d1}, #{selection_probability}], For Row #{cur_row} And #{cur_col}"
    
      @overall_prediction = selection_probability * d2 # selection_probability
    
      #puts @overall_prediction
    end
  
    def self.increment_inputs # Input taxation
      player_input       = @player_prediction
      gribatomaton_input = @gribatomaton_prediction
      enemy_input        = @enemy_prediction

      if    player_input < 50.0; # Lose HP
        if    gribatomaton_input    > enemy_input;           player_input = player_input - gribatomaton_input
        elsif enemy_input           > gribatomaton_input;    player_input = player_input - enemy_input
        end
      elsif player_input > 75.0; # Gain HP
        if    gribatomaton_input    < enemy_input;           player_input = player_input + gribatomaton_input
        elsif enemy_input           < gribatomaton_input;    player_input = player_input + gribatomaton_input
        end
      end

      if    gribatomaton_input < 50.0;
        if    player_input  > enemy_input;   gribatomaton_input = gribatomaton_input - player_input
        elsif enemy_input   > player_input;  gribatomaton_input = gribatomaton_input - enemy_input
        end
      elsif gribatomaton_input > 75.0;
        if    player_input  > enemy_input; gribatomaton_input = gribatomaton_input - player_input
        elsif enemy_input > player_input;  gribatomaton_input = gribatomaton_input - enemy_input
        end
      end

      if    enemy_input < 50.0;
        if    player_input  > enemy_input;   enemy_input = enemy_input - player_input
        elsif enemy_input   > player_input;  enemy_input = enemy_input - enemy_input
        end
      elsif enemy_input > 75.0;
        if    player_input > enemy_input;   enemy_input = enemy_input + player_input
        elsif enemy_input  > player_input;  enemy_input = enemy_input + enemy_input
        end
      end

      @player_prediction       = player_input
      @gribatomaton_prediction = gribatomaton_input
      @enemy_prediction        = enemy_input
    end
  end
  
  class Competitive
    def self.specify_measurements(a, b, c, d, e, f)
      @player_mechanic        = a
      @player_attribute       = b
    
      @gribatomaton_mechanic  = c
      @gribatomaton_attribute = d

      @enemy_mechanic         = e
      @enemy_attribute        = f
    end
  
    def self.starting_stats
      #        04     06     07     09     10
      # 04  04,04  04,06  04,07  04,07  04,10
      # 06  06,04  06,06  06,07  06,07  06,10
      # 07  07,04  07,06  07,07  07,09  07,10
      # 09  09,04  09,06  09,07  09,09  09,10
      # 10  10,04  10,06  10,07  10,09  10,10

      starting_prediction = [
        [[ 0.4,  0.4], [ 0.4, 0.6], [ 0.4, 0.7], [ 0.4, 0.9], [ 0.4, 0.10]],
        [[ 0.6,  0.4], [ 0.6, 0.6], [ 0.6, 0.7], [ 0.6, 0.9], [ 0.6, 0.10]],
        [[ 0.7,  0.4], [ 0.7, 0.6], [ 0.7, 0.7], [ 0.7, 0.9], [ 0.7, 0.10]],
        [[ 0.9,  0.4], [ 0.9, 0.6], [ 0.9, 0.7], [ 0.9, 0.9], [ 0.9, 0.10]],
        [[ 0.10, 0.4], [0.10, 0.6], [0.10, 0.7], [0.10, 0.9], [0.10, 0.10]],
      ], [
        [[ 0.4,  0.4], [ 0.4, 0.6], [ 0.4, 0.7], [ 0.4, 0.9], [ 0.4, 0.10]],
        [[ 0.6,  0.4], [ 0.6, 0.6], [ 0.6, 0.7], [ 0.6, 0.9], [ 0.6, 0.10]],
        [[ 0.7,  0.4], [ 0.7, 0.6], [ 0.7, 0.7], [ 0.7, 0.9], [ 0.7, 0.10]],
        [[ 0.9,  0.4], [ 0.9, 0.6], [ 0.9, 0.7], [ 0.9, 0.9], [ 0.9, 0.10]],
        [[ 0.10, 0.4], [0.10, 0.6], [0.10, 0.7], [0.10, 0.9], [0.10, 0.10]],
      ], [
        [[ 0.4,  0.4], [ 0.4, 0.6], [ 0.4, 0.7], [ 0.4, 0.9], [ 0.4, 0.10]],
        [[ 0.6,  0.4], [ 0.6, 0.6], [ 0.6, 0.7], [ 0.6, 0.9], [ 0.6, 0.10]],
        [[ 0.7,  0.4], [ 0.7, 0.6], [ 0.7, 0.7], [ 0.7, 0.9], [ 0.7, 0.10]],
        [[ 0.9,  0.4], [ 0.9, 0.6], [ 0.9, 0.7], [ 0.9, 0.9], [ 0.9, 0.10]],
        [[ 0.10, 0.4], [0.10, 0.6], [0.10, 0.7], [0.10, 0.9], [0.10, 0.10]],
      ]

      ## Determines player starting hp
      player_row_options = [0, 1, 2, 3, 4]
      player_col_options = [0, 1, 2, 3, 4]
      player_arr_options = [0, 1]

      p_crow = player_row_options.sample
      p_ccol = player_col_options.sample
      p_carr = player_arr_options.sample

      @player_prediction = starting_prediction[0][p_crow][p_ccol][p_carr]

      ## Determines gribatomaton's starting hp
      gribatomaton_row_options = [0, 1, 2, 3, 4]
      gribatomaton_col_options = [0, 1, 2, 3, 4]
      gribatomaton_arr_options = [0, 1]

      g_crow = gribatomaton_row_options.sample
      g_ccol = gribatomaton_col_options.sample
      g_carr = gribatomaton_arr_options.sample

      @gribatomaton_prediction = starting_prediction[1][g_crow][g_ccol][g_carr]

      ## Determines enemy starting hp
      enemy_row_options = [0, 1, 2, 3, 4]
      enemy_col_options = [0, 1, 2, 3, 4]
      enemy_arr_options = [0, 1]

      e_crow = enemy_row_options.sample
      e_ccol = enemy_col_options.sample
      e_carr = enemy_arr_options.sample

      @enemy_prediction = starting_prediction[2][e_crow][e_ccol][e_carr]
    end
  
    def self.evaluate_player
      require "SelfModifiedDecisionTree"

      attribute = ["Player"]
    
      training = [
        [0.0010,    "Some #{@player_attribute} #{@player_mechanic}"],
        [0.2505,    "Mild #{@player_attribute} #{@player_mechanic}"],
        [0.5000,  "Medium #{@player_attribute} #{@player_mechanic}"],
        [0.7495,    "High #{@player_attribute} #{@player_mechanic}"],
        [0.9990,     "Max #{@player_attribute} #{@player_mechanic}"],
      ]

      dec_tree_configurations =    DecisionTree::ID3Tree.new(attribute, training, 1, :continuous)

      current_dectree1 = dec_tree_configurations
      current_dectree1.train

      test1 = [@player_prediction, "Medium #{@player_attribute}"]

      @decision = current_dectree1.predict(test1)

      puts "Predicted: #{@decision}"

      #@net_outcome1 = "Predicted: #{@decision}"
    end
  
    def self.evaluate_gribatomaton
      require "SelfModifiedDecisionTree"
    
      attribute = ["Gribatomaton"]
    
      training = [
        [0.0010,    "Some #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.2505,    "Mild #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.5000,  "Medium #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.7495,    "High #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
        [0.9990,     "Max #{@gribatomaton_attribute} #{@gribatomaton_mechanic}"],
      ]

      dec_tree_configurations =    DecisionTree::ID3Tree.new(attribute, training, 1, :continuous)

      current_dectree1 = dec_tree_configurations
      current_dectree1.train

      test1 = [@gribatomaton_prediction, "Medium #{@gribatomaton_attribute}"]

      @decision = current_dectree1.predict(test1)

      puts "Predicted: #{@decision}"

      #@net_outcome2 = "Predicted: #{@decision}"
    end
  
    def self.evaluate_enemy
      require "SelfModifiedDecisionTree"
    
      attribute = ["Enemy"]
    
      training = [
        [0.0010,    "Some #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.2505,    "Mild #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.5000,  "Medium #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.7495,    "High #{@enemy_attribute} #{@enemy_mechanic}"],
        [0.9990,     "Max #{@enemy_attribute} #{@enemy_mechanic}"],
      ]

      dec_tree_configurations =    DecisionTree::ID3Tree.new(attribute, training, 1, :continuous)

      current_dectree1 = dec_tree_configurations
      current_dectree1.train

      test1 = [@enemy_prediction, "Medium #{@enemy_attribute}"]

      @decision = current_dectree1.predict(test1)

      puts "Predicted: #{@decision}"

      #@net_outcome3 = "Predicted: #{@decision}"
    end
  
    def self.mechanic_prediction
      matrix = [
        [[@player_mechanic,       @player_mechanic], [@player_mechanic,       @gribatomaton_mechanic], [@player_mechanic,       @enemy_mechanic]],
        [[@gribatomaton_mechanic, @player_mechanic], [@gribatomaton_mechanic, @gribatomaton_mechanic], [@gribatomaton_mechanic, @enemy_mechanic]],
        [[@enemy_mechanic,        @player_mechanic], [@enemy_mechanic,        @gribatomaton_mechanic], [@enemy_mechanic,        @enemy_mechanic]],
      ], [
        [[0.5, 0.5], [0.5, 0.5], [0.5, 0.5]],
        [[0.5, 0.5], [0.5, 0.5], [0.5, 0.5]],
        [[0.5, 0.5], [0.5, 0.5], [0.5, 0.5]],
      ]

      row_probability = 0.33
      col_probability = 0.33

      selection_probability = row_probability * col_probability
 
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1]
      
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      dice_roll = matrix[0][cur_row][cur_col][cur_arr], matrix[1][cur_row][cur_col][cur_arr]
  
      d1 = dice_roll[0]
      d2 = dice_roll[1]

      puts "[#{d1}, #{selection_probability}], For Row #{cur_row} And #{cur_col}"
    
      @overall_prediction = selection_probability * d2 # selection_probability
    
      #puts @overall_prediction
    end
  
    def self.decrement_inputs # Input taxation
      player_input       = @player_prediction
      gribatomaton_input = @gribatomaton_prediction
      enemy_input        = @enemy_prediction

      if    player_input < 50.0; # Lose HP
        if    gribatomaton_input    > enemy_input;           player_input = player_input + gribatomaton_input
        elsif enemy_input           > gribatomaton_input;    player_input = player_input + enemy_input
        end
      elsif player_input > 75.0; # Gain HP
        if    gribatomaton_input    < enemy_input;           player_input = player_input - gribatomaton_input
        elsif enemy_input           < gribatomaton_input;    player_input = player_input - gribatomaton_input
        end
      end

      if    gribatomaton_input < 50.0;
        if    player_input  > enemy_input;   gribatomaton_input = gribatomaton_input + player_input
        elsif enemy_input   > player_input;  gribatomaton_input = gribatomaton_input + enemy_input
        end
      elsif gribatomaton_input > 75.0;
        if    player_input  > enemy_input; gribatomaton_input = gribatomaton_input + player_input
        elsif enemy_input > player_input;  gribatomaton_input = gribatomaton_input + enemy_input
        end
      end

      if    enemy_input < 50.0;
        if    player_input  > enemy_input;   enemy_input = enemy_input + player_input
        elsif enemy_input   > player_input;  enemy_input = enemy_input + enemy_input
        end
      elsif enemy_input > 75.0;
        if    player_input > enemy_input;   enemy_input = enemy_input - player_input
        elsif enemy_input  > player_input;  enemy_input = enemy_input - enemy_input
        end
      end

      @player_prediction       = player_input
      @gribatomaton_prediction = gribatomaton_input
      @enemy_prediction        = enemy_input
    end
  end
end

print "How many cycles? << "; size_limit = gets.chomp.to_i

Saad::Coordinated.specify_measurements("Matraque",       "Player",
                                       "Matraque", "Gribatomaton",
                                       "Matraque",        "Enemy")

Saad::Coordinated.starting_stats

cycle = 0

Saad::Coordinated.evaluate_player
Saad::Coordinated.evaluate_gribatomaton
Saad::Coordinated.evaluate_enemy

Saad::Coordinated.mechanic_prediction

size_limit.times do
  cycle = cycle + 1
  
  puts "~~~Cycle #{cycle}"

  Saad::Coordinated.evaluate_player
  Saad::Coordinated.evaluate_gribatomaton
  Saad::Coordinated.evaluate_enemy
  Saad::Coordinated.mechanic_prediction

  Saad::Coordinated.increment_inputs
end
