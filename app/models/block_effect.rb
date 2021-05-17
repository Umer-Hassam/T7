class BlockEffect < ApplicationRecord
  belongs_to :move
  belongs_to :move_effect
end
