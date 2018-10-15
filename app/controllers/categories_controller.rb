class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
  end
end
