class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.admin?
      @comment.destroy
      redirect_to post_path(@post)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_restaurant
    @post = post.find(params[:post_id])
  end

end
