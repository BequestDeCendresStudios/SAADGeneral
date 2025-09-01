class Saad
  def self.starting_stats(a, b, c, d, e, f)
    @player_mechanic        = a
    @player_attribute       = b
    
    @gribatomaton_mechanic  = c
    @gribatomaton_attribute = d
    
    @enemy_mechanic         = e
    @enemy_attribute        = f
  end
  
  def self.evaluate_player
    require "SelfModifiedDecisionTree"
    
    attribute = ["#{@player_attribute}"]
    
    training = [
      [0.0010,    "Some #{@player_attribute}"],
      [0.2505,    "Mild #{@player_attribute}"],
      [0.5000,  "Medium #{@player_attribute}"],
      [0.7495,    "High #{@player_attribute}"],
      [0.9990,     "Max #{@player_attribute}"],
    ]

    dec_tree_configurations =    DecisionTree::ID3Tree.new(attributes, training, 1, :continuous)

    current_dectree1 = dec_tree_configurations
    current_dectree1.train

    test1 = [@player_mechanic, "Medium #{@player_attribute}"]

    @decision = current_dectree1.predict(test1)

    #puts "Predicted: Compared to #{test1.last}, Albert made #{@decision}"

    @net_outcome = "Predicted: Compared to #{test1.last}, #{@player_name} made #{@decision}"
  end
  
  def self.evaluate_gribatomaton
    require "SelfModifiedDecisionTree"
    
    attribute = ["@gribatomaton_atribute"]
    
    training = [
      [0.0010,    "Some #{@gribatomaton_attribute}"],
      [0.2505,    "Mild #{@gribatomaton_attribute}"],
      [0.5000,  "Medium #{@gribatomaton_attribute}"],
      [0.7495,    "High #{@gribatomaton_attribute}"],
      [0.9990,     "Max #{@gribatomaton_attribute}"],
    ]

    dec_tree_configurations =    DecisionTree::ID3Tree.new(attributes, training, 1, :continuous)

    current_dectree1 = dec_tree_configurations
    current_dectree1.train

    test1 = [@gribatomaton_mechanic, "Medium #{@gribatomaton_attribute}"]

    @decision = current_dectree1.predict(test1)

    #puts "Predicted: Compared to #{test1.last}, Gribatomaton made #{@decision}"

    @net_outcome = "Predicted: Compared to #{test1.last}, gribatomaton made #{@decision}"
  end
  
  def self.evaluate_enemy
    require "SelfModifiedDecisionTree"
    
    attribute = ["#{@enemy_attribute}"]
    
    training = [
      [0.0010,    "Some #{@enemy_attribute}"],
      [0.2505,    "Mild #{@enemy_attribute}"],
      [0.5000,  "Medium #{@enemy_attribute}"],
      [0.7495,    "High #{@enemy_attribute}"],
      [0.9990,     "Max #{@enemy_attribute}"],
    ]

    dec_tree_configurations =    DecisionTree::ID3Tree.new(attributes, training, 1, :continuous)

    current_dectree1 = dec_tree_configurations
    current_dectree1.train

    test1 = [@enemy_mechanic, "Medium #{@enemy_attribute}"]

    @decision = current_dectree1.predict(test1)

    #puts "Predicted: Compared to #{test1.last}, Gribatomaton made #{@decision}"

    @net_outcome = "Predicted: Compared to #{test1.last}, Enemy made #{@decision}"
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
      
    puts "[#{d1}, #{d2}], # #{selection_probability} For Row #{cur_row} And #{cur_col}"
    
    @overall_prediction = selection_probability
  end
end

Saad.starting_stats("Matraque",       "Player",
                    "Matraque", "Gribatomaton",
                    "Matraque",        "Enemy")

Saad.evaluate_player
Saad.evaluate_gribatomaton
Saad.evaluate_enemy

Saad.mechanic_prediction
