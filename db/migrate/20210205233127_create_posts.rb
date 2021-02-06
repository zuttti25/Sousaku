class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :category_id, null: false
      t.string :title, null: false
      t.text :product, null: false
      t.string :image_id
       
      t.timestamps
    end
  end
end
