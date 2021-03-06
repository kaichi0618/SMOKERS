class Shop < ApplicationRecord
  acts_as_taggable
  attachment :image
  has_many :shop_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  geocoded_by :address
  after_validation :geocode
  # 通知モデル
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :image, presence: true
  validates :shop_name, presence: true, length: { maximum: 30 }
  validates :body, presence: true
  validates :smoke_type, presence: true
  validates :address, presence: true, length: { maximum: 50 }


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # いいね通知
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and shop_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        shop_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知
  def create_notification_shop_comment!(current_user, shop_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = ShopComment.select(:user_id).where(shop_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_shop_comment!(current_user, shop_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_shop_comment!(current_user, shop_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_shop_comment!(current_user, shop_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      shop_id: id,
      shop_comment_id: shop_comment_id,
      visited_id: visited_id,
      action: 'shop_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
