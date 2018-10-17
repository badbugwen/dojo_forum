class PostsController < ApplicationController
  before_action :set_categories
  before_action :set_post, only:[:show, :collect, :uncollect, :edit, :update, :destroy]

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
    @comments = @post.comments.order(created_at: :asc)
    @comment = Comment.new
  end

  def collect
    @post.collects.create!(user: current_user)
  end

  def uncollect
    collect = Collect.where(post: @post, user: current_user)
    collect.destroy_all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.status = (params[:commit] == "Draft") ? true : false
     
    if @post.save
      create_relation
      redirect_to post_path(@post), notice: "Post was successfully created"
    else
      render :new, alert: "Post was dailed to create"
    end
  end

  def update
    @post.status = (params[:commit] == "Draft") ? true : false
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated"
    else
      render :edit, alert: "Post was failed to update"
    end
  end 

  def destroy
    @post.destroy
    redirect_back(fallback_location: root_path)
  end 

  private

  def set_categories
    @categories = Category.all
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :image, :content, :seem, :status)
  end

   def create_relation
    unless params[:categories_posts][:category_id] == ""
      @post.categories_posts.destroy_all
      category_ids = params[:categories_posts][:category_id]
      (category_ids.length - 1).times do
       CategoriesPost.create!(
          category_id: category_ids.pop,
          post_id: @post.id,
          )
      end
    end
  end

end