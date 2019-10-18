class RenameGoosColumnToUserEvaluations < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_evaluations, :goos, :good
  end
end
