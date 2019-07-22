class TimelineController < ApplicationController
  before_action :set_user

  def index
    @posts = Timeline.get_friends_posts(@user)
  end

  
  private

  def set_user
    permit = params.permit(:user_id)
    
    @user = User.find_by_id(permit[:user_id]) 
    raise "User does not exist" if @user.nil?
  end
end
