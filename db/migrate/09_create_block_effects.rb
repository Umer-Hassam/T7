class CreateBlockEffects < ActiveRecord::Migration[6.0]
  def change
    create_table :block_effects do |t|
      t.integer :move_id
      t.integer :move_effect_id

      t.timestamps
    end
  end
end
