class Character < ApplicationRecord
  has_many :moves
  has_many :stances
  
  has_many :posts
  
  has_many :fan_arts
  
  def sorted_stances
    sort_by_priority_array(stances.to_a, ["Standing", 
      "Full Crouch", 
      "While Standing", 
      "While Running",
      "Back Turned",
      "Side Step Right",
      "Side Step Left",
      "On Ground (Face Up Feet towards)", 
      "On Ground (Face Down Feet towards)", 
      "On Ground (Face Up Feet away)", 
      "On Ground (Face Down Feet away)"])
  end
  
  # def moves_sorted_by_input
#     arr_temp = moves.to_a
#
#     array_length = arr_temp.size
#     return moves if array_length <= 1
#
#     loop do
#       # we need to create a variable that will be checked so that we don't run into an infinite loop scenario.
#       swapped = false
#
#       # subtract one because Ruby arrays are zero-index based
#       (array_length-1).times do |i|
#
#
#         # MY LOGIC
#         inputPriorityArray = Move.input_priority_array
#
#         m1Array = arr_temp[i].input.split(",")
#         m2Array = arr_temp[i+1].input.split(",")
#
#         m1Index = 0
#         m2Index = 0
#         x = 0
#
#         loop do
#           m1Index = inputPriorityArray.index(m1Array[x])
#           m2Index = inputPriorityArray.index(m2Array[x])
#
#           break if x >= m1Array.count || x >= m2Array.count | m1Index != m2Index
#
#           x += 1
#         end
#         # MY LOCIC END
#
#
#         if m1Index > m2Index
#           arr_temp[i], arr_temp[i+1] = arr_temp[i+1], arr_temp[i]
#           swapped = true
#         end
#       end
#
#       break if not swapped
#     end
#
#     arr_temp
#   end
  
  def moves_sorted_by_input
    Move.sort_by_priority_array(moves.to_a, Move.input_priority_array)
  end
  
end
