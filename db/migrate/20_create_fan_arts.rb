class CreateFanArts < ActiveRecord::Migration[6.0]
  def change
    create_table :fan_arts do |t|
      t.string :link
      t.string :artist_name
      t.string :artist_link
      t.string :art_type
      t.string :style
      t.string :is_main
      t.string :description
      t.integer :character_id
      t.integer :profile_id
      
      t.timestamps
    end
  end
end
