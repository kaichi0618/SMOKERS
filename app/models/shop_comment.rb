class ShopComment < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :notifications, dependent: :destroy
  validates :shop_comment, presence: true
end
