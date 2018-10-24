class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, uniqueness: true

  mount_uploader :avatar, UserAvatarUploader
  has_many :comments, dependent: :restrict_with_error
  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post
  has_many :commented_posts, through: :comments, source: :post
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inviters, through: :inverse_friendships, source: :user

  def admin?
    self.role == "admin"
  end

  def friend?(user)
    self.friends.include?(user) || self.inviters.include?(user)
  end
  
  def all_friends
    friend_ids = []
    Friendship.where(user_id: self.id, status: true).all.each do |friendship|
      friend_ids << friendship.friend_id
    end
     Friendship.where(friend_id: self.id, status: true).all.each do |friendship|
      friend_ids << friendship.user_id
    end
    friend_ids.uniq
    friend_ids.delete_if{|i| i == self.id }
    friends_all = User.where(id: friend_ids).all
    return friends_all
  end
end
