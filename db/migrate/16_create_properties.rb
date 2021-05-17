class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :icon_link

      t.timestamps
    end
  end
end
