class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(20)
    @categories = Category.all
  end


  private
  def set_posts
    @latest_replied_posts
    @most_replied_posts
    @most_viewed_post
  end
end