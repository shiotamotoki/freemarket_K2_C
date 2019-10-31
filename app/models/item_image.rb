class ItemImage < ApplicationRecord
  belongs_to :item, inverse_of: :item_images
  mount_uploader :image, ImageUploader
end
