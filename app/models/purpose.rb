class Purpose < ApplicationRecord
  has_many :move_purposes
  has_many :moves, :through => :move_purposes
end
