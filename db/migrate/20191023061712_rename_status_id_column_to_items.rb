class RenameStatusIdColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :status_id, :status
  end
end
