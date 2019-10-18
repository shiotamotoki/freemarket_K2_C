class RenameShippingDateColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :shipping_date, :shipping_date_id
  end
end
