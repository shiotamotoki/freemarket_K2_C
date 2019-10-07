class CreatePersonalInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_informations do |t|
      t.references :user,                         null: false, foeign_key:true 
      t.string     :first_name,                   null: false
      t.string     :last_name,                    null: false
      t.string     :first_name_kana,              null: false
      t.string     :last_name_kana,               null: false
      t.date       :birth,                        null: false
      t.integer    :zip_code,                     null: false
      t.integer    :prefecture,                   null: false
      t.string     :city,                         null: false
      t.string     :address,                      null: false
      t.string     :building_name
      t.integer    :phone_number,                 :limit => 8
      t.timestamps
    end
  end
end
