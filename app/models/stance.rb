class Stance < ApplicationRecord
  belongs_to :character
  has_many :moves
  
  has_many :stance_transitions, through: :moves, :class_name => Move.to_s
  
  def parent_moves
    Move.sort_by_priority_array(moves.select {|move| move.parent == nil }.to_a, Move.input_priority_array)
  end
  def child_moves
    Move.sort_by_priority_array(moves.select {|move| move.extensions.count <= 0 || !move.cancel_input.empty?}.to_a, Move.input_priority_array)
  end
  def punisher_moves(startup)
    # get all parent moves that have same frame startup as provided
    # go through each extension and if any jails add them to the final array else add the parent move
    #moves.select{ |move| move.starup.to_i == startup.to_i }.each do |move| {}
    final_moves = []
    parent_moves.select{ |move| move.startup.to_i == startup.to_i }.each do |move|
      jailing_extensions = move.all_jailing_extensions
      if jailing_extensions.count > 0
        final_moves.concat jailing_extensions
      else
        final_moves << move
      end
    end
    
    # Finally we need to extract the moves with highest damage and highest frames
    return final_moves#[final_moves.sort_by { |move| move.total_damage_on_hit }.last, final_moves.sort_by { |move| move.on_hit }.last]
  end
  
  def moves_sorted_by_input
    Move.sort_by_priority_array(child_moves.to_a, Move.input_priority_array)
    #Move.sort_by_priority_array(moves.to_a, Move.input_priority_array)
  end
  
  # def moves_sorted_by_input
  #   arr_temp = moves.to_a
  #
  #   array_length = arr_temp.size
  #   return moves if array_length <= 1
  #
  #   loop do
  #     # we need to create a variable that will be checked so that we don't run into an infinite loop scenario.
  #     swapped = false
  #
  #     # subtract one because Ruby arrays are zero-index based
  #     (array_length-1).times do |i|
  #
  #
  #       # MY LOGIC
  #       inputPriorityArray = ["1","2","3","4","f","b","d","1+2","3+4","uf","df"]
  #
  #       m1Array = arr_temp[i].input.split(",")
  #       m2Array = arr_temp[i+1].input.split(",")
  #
  #       m1Index = 0
  #       m2Index = 0
  #       x = 0
  #
  #       loop do
  #         m1Index = inputPriorityArray.index(m1Array[x])
  #         m2Index = inputPriorityArray.index(m2Array[x])
  #
  #         break if x >= m1Array.count || x >= m2Array.count | m1Index != m2Index
  #
  #         x += 1
  #       end
  #       # MY LOCIC END
  #
  #
  #       if m1Index > m2Index
  #         arr_temp[i], arr_temp[i+1] = arr_temp[i+1], arr_temp[i]
  #         swapped = true
  #       end
  #     end
  #
  #     break if not swapped
  #   end
  #
  #   arr_temp
  # end

  def backup_moves
    json_strings = []
    moves.each do |move|
      json_strings << move.backup_json
    end
    return "[" + json_strings.join(",") + "]"
  end

  def self.restore(json_string)
    bb = JSON.parse json_string

    move = Move.create(
      :input => bb["input"], 
      :name => bb["name"],

      #:stance => ["stance"],
      #:parent => ["parent"],
      :cancel_input => bb["cancel_input"],

      #Frames
      :startup => bb["startup"],
      :on_block => bb["on_block"],
      :on_hit => bb["on_hit"],
      :on_counter_hit => bb["on_counter_hit"],
      
      #damage info
      :hit_damage =>        bb["hit_damage"],
      :conter_hit_damage => bb["conter_hit_damage"],
      :hit_level =>         bb["hit_level"],

      #:counter => counter,

      #:move_purpose => MovePurpose.where('lower(name) = ?', bb["move_purpose"][0].downcase).first,
      #:properties =>   properties.map { |p| p.name },

      #:effects_hit =>         effects_hit.map { |p| p.name },
      #:effects_counter_hit => effects_counter_hit.map { |p| p.name },
      #:effects_block =>       effects_block.map { |p| p.name },
      )
  
    if !bb["stance"].empty?
      move.stance = Stance.where('lower(name) = ?', bb["stance"].downcase).first
    end
  
    #byebug
    
  end
end
