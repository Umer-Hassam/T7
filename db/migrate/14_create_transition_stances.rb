class CreateTransitionStances < ActiveRecord::Migration[6.0]
  def change
    create_table :transition_stances do |t|
      t.integer :move_id
      t.integer :stance_id

      t.timestamps
    end
  end
end
