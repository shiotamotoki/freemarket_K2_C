class CreateUserEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_evaluations do |t|
      t.references   :user,                   null: false, foeign_key:true 
      t.integer      :goos,                 null: false, default:"0"
      t.integer      :normal,                 null: false, default:"0"
      t.integer      :bad,                 null: false, default:"0"
      t.timestamps
    end
  end
end