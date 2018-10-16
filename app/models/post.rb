class Post < ApplicationRecord
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :collects, dependent: :destroy
  has_many :collectors, through: :collects, source: :user
end
