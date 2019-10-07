class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references   :user,                          null: false, foeign_key:true
      t.references   :item,                          null: false, foeign_key:true 
      t.timestamps
    end
  end
end