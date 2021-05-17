class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.string :name
      
      #inputs
      t.string :input
      t.string :cancel_input

      #frame data
      t.string :startup
      t.string :on_block
      t.string :on_hit
      t.string :on_counter_hit
      
      #damage info
      t.string :hit_damage
      t.string :conter_hit_damage
      t.string :hit_level
      
      t.string :type
      t.text :counter
      t.integer :character_id
      
      t.references :parent
      
      t.timestamps
    end
  end
end
