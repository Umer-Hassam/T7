class MoveExtension < ApplicationRecord
  belongs_to :extension, foreign_key: "extension_id", class_name: Move.to_s
  belongs_to :parent, foreign_key: "parent_id", class_name: Move.to_s
end
