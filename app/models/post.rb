class Post < ApplicationRecord

attachment :image

belongs_to :user
belongs_to :category
# いいね機能のアソシエーション
has_many :likes
has_many :liked_users, through: :likes, source: :user
has_many :comments, dependent: :destroy

end
