class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|

      t.references :user, foreign_key: true, null: false
      t.text :essential, null: false
      t.text :requirement, null: false
      t.string :address, null: false 

      t.timestamps
    end
  end
end
