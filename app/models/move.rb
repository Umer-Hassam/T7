class Move < ApplicationRecord
  validate :custom_validation
  
  before_destroy :destroy_extensions

  private def custom_validation
    if !self.parent.blank?
      if (self.parent.extensions.select { |m| m.persisted? && m.input == self.input && m.cancel_input == self.cancel_input}.count > 0 )
        self.errors[:base] << "Another Extensions of this moves parent already has the same input and the cancel input. This is not allowed"
      end

      if self.parent.stance_id != self.stance_id
        self.errors[:base] << "Stance must be the same as parent move. Parent's Stance: #{self.parent.stance.name}"
      end

    else
      
      if (self.stance.moves.select { |m| m.persisted? && m.input == self.input && m.cancel_input == self.cancel_input}.count > 0 )
        self.errors[:base] << "Another move already has the same input and the cancel input. This is not allowed."
      end
    end
    
  end

  def destroy_extensions
    self.extensions.destroy_all
  end

  belongs_to :character
  
  # STANCES
  belongs_to :stance
  
  has_many :transition_stances
  has_many :stance_transitions, :through => :transition_stances, :source => :stance
  
  # MOVE EFFECTS
  has_many :hit_effects
  has_many :counter_hit_effects
  has_many :block_effects
  
  has_many :effects_hit,         :through => :hit_effects,         :source => :move_effect
  has_many :effects_counter_hit, :through => :counter_hit_effects, :source => :move_effect
  has_many :effects_block,       :through => :block_effects,       :source => :move_effect
  
  # MOVE PURPOSES
  has_many :move_purposes
  has_many :purposes, :through => :move_purposes
  
  # MOVE PROPERTIES
  has_many :move_properties
  has_many :properties, :through => :move_properties
  
  # EXTENSION
#   has_many :move_extensions, foreign_key: :extension_id, class_name: MoveExtension.to_s
#   has_many :extensions, through: :move_extensions, source: :extension
#
#   # followee_follows "names" the Follow join table for accessing through the followee association
#   has_many :move_parents, foreign_key: :parent_id, class_name: MoveExtension.to_s
#   # source: :followee matches with the belong_to :followee identification in the Follow model
#   has_many :parents, through: :move_parents, source: :parent
  has_many :extensions, class_name: "Move", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Move", optional: true
  
#  has_many :followers, foreign_key: :follower_id , class_name: "Friendship"
  has_many :preceding_move_options, foreign_key: :followup_move_id, class_name: "Followup"
  has_many :preceding_moves, through: :preceding_move_options, source: :preceding_move
#  has_many :followed, through: :followers
#  has_many :followup_moves, through: :preceding_moves

#  has_many :followed, foreign_key: :followed_id, class_name: "Friendship"
  has_many :followup_move_options, foreign_key: :preceding_move_id, class_name: "Followup"
  has_many :followup_moves, through: :followup_move_options, source: :followup_move
  
#  has_many :followers, through: :followed
#  has_many :preceding_moves, through: :followup_moves
  
  def eldest_move 
    em = self
    loop do
      break if em.parent == nil
      em = em.parent
    end
    return em
  end
  
  # This method calculates the complete input of the string until selected move
  def complete_input_array
    currMove = self
    inputArray = [currMove]
    while currMove.parent != nil
    	currMove = currMove.parent
    	inputArray << currMove
    end
    return inputArray
  end
  
  # This method returns true if the move jails all the way to the parent move, some moves can jail after the first hit
  def true_jails_on_hit? 
    true_jails = true
    em = self
    loop do
      
      break if em.parent == nil
      
      if !em.jails_on_hit?
        true_jails = false
        break
      end
      
      em = em.parent
    end
    return true_jails
  end
  
  def total_damage_on_hit
    total = 0
    total_damage_on_hit_array.each do |dmg|
      total += dmg
    end
    return total
  end
  
  def all_jailing_extensions
    jailing_extensions = []
    extensions.each do |e|
      child_jailing_extensions = e.all_jailing_extensions
      if child_jailing_extensions.count > 0 
        jailing_extensions << child_jailing_extensions
      elsif
        if e.true_jails_on_hit?
          jailing_extensions << e
        end
      end
    end
    return jailing_extensions
  end
  
  def total_damage_on_hit_array
    em = self
    dmg = []
    loop do
      dmg << em.hit_damage.to_i
      break if em.parent == nil
      em = em.parent
    end
    return dmg
  end
  
  def jails_on_hit?
    effects_hit.where(name: "Jails").count > 0
  end
  def jails_on_counter_hit?
    effects_counter_hit.where(name: "Jails").count > 0
  end
  def jails_on_block?
    effects_block.where(name: "Jails").count > 0
  end
  
  def is_grab?
    return properties.select { |prop| prop.name == "Grab" }.count > 0
  end
  
  def hit_effects_presentable_strings
    a = ""
    b = ""
    effects_hit.each do |he|
      x = he.name.split('(')

      a = x[0]

      if x.count > 1
        b = "(" + x[1]
      end
      
    end

    return a, b
  end

  def counter_hit_effects_presentable_strings
    a = ""
    b = ""
    effects_counter_hit.each do |he|
      x = he.name.split('(')

      a = x[0]

      if x.count > 1
        b = "(" + x[1]
      end
      
    end

    return a, b
  end


  def track_direction
    if properties.where(name: "Tracks Left").count > 0
      return "Left"
    elsif properties.where(name: "Tracks Right").count > 0
      return "Right"
    elsif properties.where(name: "Tracks Both").count > 0
      return "Both"
    else
      return "None"
    end
  end
  
  # SORT METHODS
  
  def self.input_priority_array
    inputPriorityArray = ["1","2","3","4","1+2","2+3","3+4","1+4","1+3","2+4","f","df","d","db","b","ub","u","uf"]
  end
  
  def self.sort_by_priority_array(array_to_sort, priority_array)
    arr_temp = array_to_sort#moves.to_a
    
    array_length = arr_temp.size
    return array_to_sort if array_length <= 1
    print array_to_sort
    loop do
      # we need to create a variable that will be checked so that we don't run into an infinite loop scenario.
      swapped = false
      
      # subtract one because Ruby arrays are zero-index based
      (array_length-1).times do |i|
        
        
        # MY LOGIC
        inputPriorityArray = priority_array
        
        m1Array = arr_temp[i].eldest_move.input.split(",")
        m2Array = arr_temp[i+1].eldest_move.input.split(",")
      
        m1Index = 0
        m2Index = 0
        x = 0
      
        loop do
          m1Index = inputPriorityArray.index(m1Array[x])
          m2Index = inputPriorityArray.index(m2Array[x])
        
          break if x >= m1Array.count || x >= m2Array.count | m1Index != m2Index
        
          x += 1
        end
        # MY LOCIC END
        
        
        if m1Index > m2Index
          arr_temp[i], arr_temp[i+1] = arr_temp[i+1], arr_temp[i]
          swapped = true
        end
      end

      break if not swapped
    end
    
    arr_temp
  end
  
  def backup_dict()
    
    dict = {
      :input => input, 
      :name => name,

      #:stance => stance.name,
      :parent => parent == nil ? "" : parent.input,
      :cancel_input => cancel_input,

      #Frames
      :startup => startup,
      :on_block => on_block,
      :on_hit => on_hit,
      :on_counter_hit => on_counter_hit,
      
      #damage info
      :hit_damage =>         hit_damage,
      :conter_hit_damage => conter_hit_damage,
      :hit_level =>         hit_level,

      :counter => counter,

      :move_purpose => purposes.map { |p| p.name },
      :properties =>   properties.map { |p| p.name },

      :effects_hit =>         effects_hit.map { |p| p.name },
      :effects_counter_hit => effects_counter_hit.map { |p| p.name },
      :effects_block =>       effects_block.map { |p| p.name },

    }

    if extensions.blank? 
      
      return dict
      
    else
      
      ext_json_array = []

      extensions.each do |extension|
         ext_json_array << extension.backup_dict
      end
      
      dict[:child_moves] = ext_json_array
      return dict

    end

    

  end
end
