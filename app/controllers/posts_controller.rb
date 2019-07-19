class PostsController < ApplicationController

  def index
    @posts = Post.all.order(id: :desc)
  end
  
  def create
    @post = Post.create(permit_params)
  end


  private

  def permit_params
    params.require(:post).permit(:text, image_attributes: [:file])
  end

end
