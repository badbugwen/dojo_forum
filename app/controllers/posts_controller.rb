class PostsController < ApplicationController

  def index
    @posts = Post.order(comments_count: :desc).page(params[:page]).per(20)
    @categories = Category.all
  end

  def last_replied
    ids = []
    Comment.all.order(created_at: :asc).each do |comment|
      ids << comment.post.id
    end
    ids.uniq

    @posts = Post.joins(:comments).group("created_at").order(created_at: :desc).page(params[:page]).per(20) 
    @categories = Category.all
  end

  def most_viewed
    @posts = Post.order(viewed_count: :desc).page(params[:page]).per(20)
    @categories = Category.all
  end

  def show
  end


  
end