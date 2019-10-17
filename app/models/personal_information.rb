class PersonalInformation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user ,optional: true
  belongs_to_active_hash :prefecture
end
