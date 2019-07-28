class PostsController < ApplicationController

  def index
    @posts = Timeline.get_friends_posts(current_user).order(id: :desc)
  end
  
  def create
    @post = current_user.posts.create(permit_params)
  end


  private

  def permit_params
    params.require(:post).permit(:text, image_attributes: [:file])
  end

end
