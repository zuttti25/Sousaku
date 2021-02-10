class RemoveFieldFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :field, :string
  end
end
