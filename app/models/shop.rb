class Shop < ApplicationRecord
  acts_as_taggable
  attachment :image
  has_many :shop_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  geocoded_by :address
  after_validation :geocode

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
