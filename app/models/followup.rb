class Followup < ApplicationRecord
#  belongs_to :preceding_move, class_name: "Move"
#   belongs_to :followup_move, class_name: "Move"
  
  belongs_to :preceding_move, foreign_key: "preceding_move_id", class_name: "Move"
  belongs_to :followup_move, foreign_key: "followup_move_id", class_name: "Move"
end
