class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :item_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :buyer, dependent: :destroy
  
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :shippingdate
  belongs_to_active_hash :clothingsize
  belongs_to_active_hash :shoessize
end
