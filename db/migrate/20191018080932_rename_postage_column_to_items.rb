class RenamePostageColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :postage, :postage_id
  end
end
