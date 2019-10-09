class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references   :user,                   null: false, foeign_key:true 
      t.string       :name,                   null: false
      t.text         :description
      t.references   :category,               null: false, foeign_key:true 
      t.integer      :size
      t.references   :brand,                               foeign_key:true, default:"0"
      t.integer      :condition,              null: false
      t.integer      :postage,                null: false
      t.integer      :area,                   null: false
      t.integer      :shipping_date,          null: false
      t.integer      :price,                  null: false
      t.integer      :status,                 null: false
      t.timestamps
    end
  end
end