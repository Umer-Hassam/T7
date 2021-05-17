class CreateInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :inputs do |t|
      t.string :name
      t.string :image_url
      t.boolean :is_direction

      t.timestamps
    end
    
  end
end
