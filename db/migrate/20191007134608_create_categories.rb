class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string     :name,                   null: false
      t.string     :path
      t.timestamps
    end
  end
end
