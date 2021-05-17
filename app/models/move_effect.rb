class MoveEffect < ApplicationRecord
  has_many :moves
  has_many :effects_hit, through: :hit_effects, :class_name => Move.to_s
end
