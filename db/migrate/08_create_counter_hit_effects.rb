class CreateCounterHitEffects < ActiveRecord::Migration[6.0]
  def change
    create_table :counter_hit_effects do |t|
      t.integer :move_id
      t.integer :move_effect_id

      t.timestamps
    end
  end
end
