class Property < ApplicationRecord
  has_many :move_properties
  has_many :moves, :through => :move_properties
end
