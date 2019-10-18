class RenameZipCodeColumnToPersonalInformations < ActiveRecord::Migration[5.2]
  def change
    rename_column :personal_informations, :zip_code, :postal_code
  end
end
