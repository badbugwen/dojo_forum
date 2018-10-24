class CategoriesController < ApplicationController
  before_action :set_category
   before_action :set_categories

  def show
    @posts = @category.posts.all.order(id: :desc).page(params[:page]).per(20) 
  end

  def last_replied
    @posts = @category.posts.includes(:comments).order("comments.created_at desc").page(params[:page]).per(20)
  end

  def most_viewed
    @posts = @category.posts.order(viewed_count: :desc).page(params[:page]).per(20)
  end

  def most_replies
    @posts = @category.posts.order(comments_count: :desc).page(params[:page]).per(20)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

end
