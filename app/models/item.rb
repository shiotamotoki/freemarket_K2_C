class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
 
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true

  has_many :likes, dependent: :destroy
  has_one :buyer, dependent: :destroy
  
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :size

  # バリデーション
  validates :name, length: { in: 1..40 }
  validates :description, length: { in: 1..1000 }
  validates :category_id, numericality: {message: 'を選択してください'}
  validates :size_id, numericality: {message: 'を選択してください'}, allow_nil: true
  validates :status, presence: {
    if: proc { |d| d.status == nil },
    message: 'を選択してください' 
  }
  validates :postage_id, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :prefecture_id, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :shipping_date_id, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :price,  numericality: {only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9999999,
                                    message: 'は300以上9999999以下で入力してください' }
                                    
end
