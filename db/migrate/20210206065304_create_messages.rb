class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
