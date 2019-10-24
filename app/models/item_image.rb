class ItemImage < ApplicationRecord
  belongs_to :item, inverse_of: :item_images
end
