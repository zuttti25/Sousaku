class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  attachment :image

  has_many :posts
  #has_many :comments, dependent: :destroy
  # いいね機能のアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # ユーザーがすでにいいね済か否かを判断する。
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
