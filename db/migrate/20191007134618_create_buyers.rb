class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.references   :user,                   null: false, foeign_key:true 
      t.references   :item,                   null: false, foeign_key:true 
      t.timestamps
    end
  end
end
