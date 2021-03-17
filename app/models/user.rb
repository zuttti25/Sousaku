class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  attachment :image

  has_many :posts
  has_many :boards
  has_many :comments, dependent: :destroy
  # いいね機能のアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy
  # フォロー機能のアソシエーション
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  # DM機能のアソシエーション
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  #通知機能のアソシエーション
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  with_options presence: true do
	  validates :email
	  validates :encrypted_password
	  validates :name
	end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name:'ゲストさん') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # ユーザーがすでにいいね済か否かを判断する。
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  # フォロー機能に必要なメソッドを定義
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  #フォロー時の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
     )
    notification.save if notification.valid?
    end
  end

  #検索のインスタンスメソッド
  def User.search(search, searchs)
    if searchs == "1"
       User.where(['name LIKE ?', "%#{search}%"])
    else
       User.all
    end

  end

end