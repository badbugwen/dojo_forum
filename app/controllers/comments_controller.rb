class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to post_path(@post)
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_user_path(current_user), notice: "Comment was successfully updated"
    end
  end

  def destroy
    params[:session] = @comment.post.id
    @post = Post.find_by(id:  params[:session])
    if current_user.admin? || current_user == @comment.user
      @comment.destroy
      redirect_back(fallback_location: comment_user_path(current_user))
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
