class AddAndChangeColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    change_column :posts, :status, :boolean
  end
end
