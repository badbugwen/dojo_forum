class Api::V1::PostsController < ApiController
  before_action :set_post, only:[:show, :update, :destroy]
  before_action :authenticate_user!, except: :index
  def index
    @posts = Post.all
    render json:  @posts
  end

  def show
    
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }  
    else
      render json: @post
      @post.increase_view
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.status = (params[:commit] == "Draft") ? true : false
    if @post.save
      create_relation
      render json: {
        message: "Post was successfully created",
        result: @post
      }
    else
      render json:{
        message: @post.errors
      }
    end
  end

  def update
    @post.status = (params[:commit] == "Draft") ? true : false
    if @post.update(post_params)
      create_relation
      render json:{
        message: "Post was successfully updated",
        result: @post
      }
      return
    else
      render jason:{
      message: @post.errors
      }
    end
  end 

  def destroy
    if current_user == @post.user || current_user.admin?
      @post.destroy
      render json: {
        message: "Post was successfully deleted"
      }
    end
  end 

  private
  def post_params
    params.permit(:title, :image, :content, :seem, :status)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
