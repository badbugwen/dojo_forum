class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  before_action :set_category, only: [:update, :destroy]
  before_action :set_categories, only: [:index, :create, :update]

  def index
    # set_categories
    if params[:id]
      set_category
    else
      @category = Category.new 
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "New category was successfully created!"
    else 
      # set_categories
      render :index
    end  
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category was successfully updated!" 
    else 
      # set_categories
      render :index
    end  
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, alert: "分類已刪除"
  end 

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
  @category = Category.find(params[:id])
  end

  def set_categories
   @categories = Category.all
  end  

end
