class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader
  validates_presence_of :title, :content, :seem
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :collects, dependent: :destroy
  has_many :collectors, through: :collects, source: :user
end
