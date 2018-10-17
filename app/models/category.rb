class Category < ApplicationRecord
  validates_presence_of :name

  has_many :posts, dependent: :restrict_with_error
  has_many :categories_posts
end
