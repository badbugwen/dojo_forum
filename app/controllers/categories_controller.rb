class CategoriesController < ApplicationController
  before_action :set_category
   before_action :set_categories

  def show
    @posts = Post.all.order(id: :desc).page(params[:page]).per(20) 
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

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

end
