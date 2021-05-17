class CreateMovePurposes < ActiveRecord::Migration[6.0]
  def change
    create_table :move_purposes do |t|
      t.integer :move_id
      t.integer :purpose_id

      t.timestamps
    end
  end
end
