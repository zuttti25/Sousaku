class Board < ApplicationRecord

  belongs_to :user

  def Board.search(search, searchs)
    if searchs == "4"
       Board.where(['title LIKE ?', "%#{search}%"])
    else
       Board.all
    end
  end

end
