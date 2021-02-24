class Board < ApplicationRecord

  belongs_to :user

  with_options presence: true do
	  validates :title
	  validates :essential
	  validates :requirement
	  validates :address
	end


  def Board.search(search, searchs)
    if searchs == "4"
       Board.where(['title LIKE ?', "%#{search}%"])
    else
       Board.all
    end
  end

end
