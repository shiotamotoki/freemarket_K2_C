class RenameStatusColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :status, :status_id
  end
end
