class Shop < ApplicationRecord
  attachment :image
  has_many :shop_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :genre
end
