class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :personal_information, dependent: :destroy
  accepts_nested_attributes_for :personal_information
  has_many :items, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :user_evaluation, dependent: :destroy
  has_many :buyers, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nickname,                  presence: true, uniqueness: true
  validates :email,                     presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                  presence: true, length: {minimum: 7, maximum: 128}
  validates :password_confirmation,     presence: true, length: {minimum: 7, maximum: 128}

end
