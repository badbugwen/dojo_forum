class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_back(fallback_location: root_path, notice: "Send friend request to #{User.find_by(id: params[:friend_id]).name}!")
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    @friendship.update_all(user_id: params[:id], friend_id: current_user.id, status: true)
    flash[:notice] = "Accept #{User.find_by(id: params[:id]).name}'s friend request!"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    @friendship.destroy_all
    flash[:alert] = "Reject #{User.find_by(id: params[:id]).name}'s friend request!"
    redirect_back(fallback_location: root_path)
  end

  private
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end

end
