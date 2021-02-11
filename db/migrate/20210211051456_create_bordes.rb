class CreateBordes < ActiveRecord::Migration[5.2]
  def change
    create_table :bordes do |t|

      t.timestamps
    end
  end
end
