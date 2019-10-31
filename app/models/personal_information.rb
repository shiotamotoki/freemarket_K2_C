class PersonalInformation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user ,optional: true
  belongs_to_active_hash :prefecture

  validates :birth,                     presence: true
  validates :first_name,                presence: true, length: { maximum: 35 }
  validates :last_name,                 presence: true, length: { maximum: 35 }
  validates :first_name_kana,           presence: true, length: { maximum: 35 }, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :last_name_kana,            presence: true, length: { maximum: 35 }, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :postal_code,               presence: true
  validates :prefecture_id,             presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :city,                      presence: true
  validates :address,                   presence: true
end
