class Post < ApplicationRecord

attachment :image
# PV数を計測
is_impressionable counter_cache: true

belongs_to :user
belongs_to :category
has_many :likes, dependent: :destroy
has_many :liked_users, through: :likes, source: :user, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :notifications, dependent: :destroy
has_many :tagmaps, dependent: :destroy
has_many :tags, through: :tagmaps


#いいねのインスタンスメソッド
def create_notification_like!(current_user)
  # すでに「いいね」されているか検索
  temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
  # いいねされていない場合のみ、通知レコードを作成
  if temp.blank?
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: 'like'
    )
    # 自分の投稿に対するいいねの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

#コメントのインスタンスメソッド
def create_notification_comment!(current_user, comment_id)
  # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
  temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
  temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
  end
  # まだ誰もコメントしていない場合は、投稿者に通知を送る
  save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
end

def save_notification_comment!(current_user, comment_id, visited_id)
  # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
  notification = current_user.active_notifications.new(
    post_id: id,
    comment_id: comment_id,
    visited_id: visited_id,
    action: 'comment'
  )
  # 自分の投稿に対するコメントの場合は、通知済みとする
  if notification.visitor_id == notification.visited_id
    notification.checked = true
  end
  notification.save if notification.valid?
end

# タグのインスタンスメソッド
def save_posts(tags)
  current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?

  old_tags = current_tags - tags # Destroy
  new_tags = tags - current_tags # Create

  old_tags.each do |old_name|
    self.tags.delete Tag.find_by(tag_name:old_name)
  end

  new_tags.each do |new_name|
    post_tag = Tag.find_or_create_by(tag_name:new_name)
    self.tags << post_tag
  end
end

end
