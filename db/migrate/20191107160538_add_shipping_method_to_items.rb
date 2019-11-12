class AddShippingMethodToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shipping_method_id, :integer,null: false
  end
end
