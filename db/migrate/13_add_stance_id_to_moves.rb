class AddStanceIdToMoves < ActiveRecord::Migration[6.0]
  def change
    add_column :moves, :stance_id, :integer
  end
end
