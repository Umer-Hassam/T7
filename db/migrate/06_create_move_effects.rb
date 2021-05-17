class CreateMoveEffects < ActiveRecord::Migration[6.0]
  def change
    create_table :move_effects do |t|
      t.string :name
      t.string :image_url
      t.text :desc

      t.timestamps
    end
  end
end
