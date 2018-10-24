class Api::V1::PostsController < ApiController

  def index
    @posts = Post.all
    render json: {
      data: @posts
    }
  end

  def show
    
  end
end
