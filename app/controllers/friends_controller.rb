class FriendsController < ApplicationController

  def index
    @friends = current_user.friend_list
  end
end
