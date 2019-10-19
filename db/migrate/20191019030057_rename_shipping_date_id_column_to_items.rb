class RenameShippingDateIdColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :shipping_date_id, :shippingdate_id
  end
end
