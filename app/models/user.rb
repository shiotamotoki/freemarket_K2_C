class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :personal_information, dependent: :destroy
  accepts_nested_attributes_for :personal_information
  has_many :items
  has_many :credit_cards, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :user_evaluation, dependent: :destroy
  has_many :buyers, dependent: :destroy

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
