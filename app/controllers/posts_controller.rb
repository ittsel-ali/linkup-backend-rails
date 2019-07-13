class PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  
  def create
    post = Post.create(permit_params)

    render json: post.image.file_url(:mobile)
  end


  private

  def permit_params
    params.require(:post).permit(:text, image_attributes: [:file])
  end

end
