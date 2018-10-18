class UsersController < ApplicationController
  before_action :set_user
  def show
    @posts = Post.where(user_id: @user.id, status: false).all.order(created_at: :asc)
  end

  def update
    if @user == current_user
      # only userself can update profile in right format
      if @user.update(user_params)
        redirect_to user_path(params[:id]), notice: "User's profile was successfully updated"
      else
        render :edit
      end
    else
        redirect_to user_path(params[:id]), alert: "You can not edit other user's profile!"
    end
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

  def friend
    @asking_friends
    @requiring_friends
    @friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
    end
end
