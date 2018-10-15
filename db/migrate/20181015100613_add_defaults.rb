class AddDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :role, "Normal"
    change_column_default :posts, :replies_count, 0
    change_column_default :posts, :viewed_count, 0
  end
end
