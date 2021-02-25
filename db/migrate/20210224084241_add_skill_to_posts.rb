class AddSkillToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :skill, :string
  end
end