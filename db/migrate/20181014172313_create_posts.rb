class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image
      t.string :seem
      t.string :status
      t.text   :content
      t.integer :user_id
      t.integer :category_id
      t.integer :replies_count
      t.integer :viewed_count

      t.timestamps
    end
  end
end
