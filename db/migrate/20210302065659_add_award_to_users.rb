class AddAwardToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :award, :string
  end
end
