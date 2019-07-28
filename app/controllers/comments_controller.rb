class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.create(permit_params)
    
    current_user.friend_list(true).each do |friend|
      Notifier.trigger_comment(friend.tokens.last.token, @comment, @comment.post.id, "ShowPost")
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def permit_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end
end
