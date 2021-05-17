class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :details
      t.string :post_type
      t.integer :character_id
      t.integer :user_id

      t.timestamps
    end
  end
end
