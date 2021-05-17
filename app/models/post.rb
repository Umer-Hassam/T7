class Post < ApplicationRecord
  belongs_to :user
  belongs_to :character
  
  # POST TYPES
  # G0: General Guides
  # C0: Character Guides
  # CO0: Character Other Video Guides
  # CO1: Character Quick Tips
  # CO2: Characetr Other Match Videos
  # CA0: Character Anti Quick Tips
  # CA1: Character Anti External Sources
  # M0: Move Comments
end
