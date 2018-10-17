class PostsController < ApplicationController
  before_action :set_categories

  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(20)
  end

  def last_replied
    ids = []
    Comment.all.order(created_at: :asc).each do |comment|
      ids << comment.post.id
    end
    ids.uniq

    @posts = Post.joins(:comments).group("created_at").order(created_at: :desc).page(params[:page]).per(20) 
  end

  def most_viewed
    @posts = Post.order(viewed_count: :desc).page(params[:page]).per(20)
  end

  def most_replies
    @posts = Post.order(comments_count: :desc).page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :asc)
    @comment = Comment.new
  end

  def collect
    @post = Post.find(params[:id])
    @post.collects.create!(user: current_user)
  end

  def uncollect
    @post = Post.find(params[:id])
    collect = Collect.where(post: @post, user: current_user)
    collect.destroy_all
  end

  private

  def set_categories
    @categories = Category.all
  end

end