class ChangeCoiumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :comments_count, :comments_count
  end
end
