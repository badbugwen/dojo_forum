class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader
  validates_presence_of :title, :content, :seem
  belongs_to :category, optional: true
  has_many :categories_posts
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :collects, dependent: :destroy
  has_many :collectors, through: :collects, source: :user

  def is_collected?(user)
    self.collectors.include?(user)
  end

  def increase_view
    self.viewed_count+=1
    self.save!
  end
end
