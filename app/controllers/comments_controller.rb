class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.create(permit_params)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def permit_params
    params.require(:comment).permit(:text)
  end
end
