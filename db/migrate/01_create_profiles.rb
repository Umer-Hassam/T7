class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :nickname
      t.boolean :isadmin

      t.timestamps
    end
  end
end
