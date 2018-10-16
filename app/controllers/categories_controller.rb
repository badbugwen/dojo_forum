class CategoriesController < ApplicationController
  before_action :set_category

  def show
    @categories = Category.all
    @posts = Post.all.order(comments_count: :desc).page(params[:page]).per(20) 
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

  private

  def set_category
    @category = Category.find(params[:id])
  end

end
