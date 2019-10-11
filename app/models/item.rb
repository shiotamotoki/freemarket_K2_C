class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :item_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :buyer, dependent: :destroy
end
