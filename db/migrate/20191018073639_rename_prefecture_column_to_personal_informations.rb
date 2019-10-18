class RenamePrefectureColumnToPersonalInformations < ActiveRecord::Migration[5.2]
  def change
    rename_column :personal_informations, :prefecture, :prefecture_id
  end
end
