class CreateMoveExtensions < ActiveRecord::Migration[6.0]
  def change
    create_table :move_extensions do |t|
      t.integer :extension_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
