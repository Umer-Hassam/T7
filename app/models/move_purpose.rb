class MovePurpose < ApplicationRecord
  belongs_to :move
  belongs_to :purpose
end
