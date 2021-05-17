class CreateFollowups < ActiveRecord::Migration[6.0]
  def change
    create_table :followups do |t|
      t.integer :preceding_move_id
      t.integer :followup_move_id
      
      t.boolean :is_guaranteed
      t.integer :hit_status
      t.string :explanation

      t.timestamps
    end
  end
end
