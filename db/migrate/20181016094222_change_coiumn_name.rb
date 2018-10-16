class ChangeCoiumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :replies_count, :comments_count
  end
end
