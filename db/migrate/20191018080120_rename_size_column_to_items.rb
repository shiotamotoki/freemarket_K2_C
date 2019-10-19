class RenameSizeColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :size, :size_id
  end
end
