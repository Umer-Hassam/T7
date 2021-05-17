class CreateMoveProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :move_properties do |t|
      t.integer :move_id
      t.integer :property_id
      
      t.timestamps
    end
  end
end
