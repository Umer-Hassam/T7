class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :wiki_link
      t.string :full_image_link
      t.string :thumb_image_link
      t.string :fighting_style
      t.string :archetype
      t.string :difficulty
      t.string :tier
      t.string :publish
      t.text :gameplay
      t.text :strengths
      t.text :weaknesses

      t.timestamps
    end
  end
end
