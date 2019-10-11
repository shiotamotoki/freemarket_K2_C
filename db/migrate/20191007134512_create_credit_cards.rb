class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.references   :user,                          null: false, foeign_key: true
      t.integer      :number,                        null: false, unique: true
      t.integer      :month,                         null: false
      t.integer      :year,                          null: false
      t.integer      :security_code,                 null: false
      t.timestamps
    end
  end
end