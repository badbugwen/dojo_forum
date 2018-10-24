class UsersController < ApplicationController
  before_action :set_user
  def show
    @posts = Post.where(user_id: @user.id).all.order(created_at: :asc)
  end

  def edit
    unless @user == current_user
      flash[:alert] = "Profile editing in person only!"
      redirect_to user_path(@user)
    end
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
        redirect_to user_path(params[:id]), alert: "Profile editing in person only!"
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
    asking_ids = []
    Friendship.where(user_id: @user.id, status: false ).find_each do |friendship|
      asking_ids << friendship.friend_id
    end
    @asking_friends = User.where(id: asking_ids).all

    requiring_ids = []
    Friendship.where(friend_id: @user.id, status: false).find_each do |friendship|
      requiring_ids << friendship.user_id
    end
    @requiring_friends = User.where(id: requiring_ids)

    @my_friends = @user.all_friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
    end
end
