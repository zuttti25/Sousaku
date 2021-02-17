class Tag < ApplicationRecord

  has_many :tagmaps, dependent: :destroy
  has_many :posts, through: :tagmaps

  def Tag.search(search, searchs)
    if searchs == "3"
       Tag.where(['tag_name LIKE ?', "%#{search}%"])
    else
       Tag.all
    end
  end

end
