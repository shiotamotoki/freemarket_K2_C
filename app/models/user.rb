class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :personal_information, dependent: :destroy
  accepts_nested_attributes_for :personal_information

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
