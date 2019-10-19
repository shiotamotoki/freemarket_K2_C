class RenameShippingdateIdColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :shippingdate_id, :shipping_date_id
  end
end
