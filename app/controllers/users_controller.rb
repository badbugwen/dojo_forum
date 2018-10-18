class UsersController < ApplicationController
  before_action :set_user
  def show
    @posts = Post.where(user_id: @user.id, status: false).all.order(created_at: :asc)
  end

  def draft
    @posts = Post.where(user_id: @user.id, status: true).all.order(created_at: :asc)
  end

  def collection
    @posts = @user.collected_posts.all.order(created_at: :asc)
  end

  def comment
    @posts = @user.commented_posts.all.order(created_at: :asc)
    @comments = @user.comments.all.order(created_at: :asc)
     
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
