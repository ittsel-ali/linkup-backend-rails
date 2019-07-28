class FriendsController < ApplicationController
  def index
    @friends = current_user.friend_list(true)
  end

  def requests
    @friend_requests = current_user.friend_list(false)
  end

  def invite_friend 
    fuser = User.find(params[:friend_id])
    
    record = fuser.friends.create(friend_id: current_user.id)
    if record.save
      Notifier.trigger_FR(fuser.tokens.last.token, current_user)
    end

    return render json: {message: "Inivitation sent"}
  end

  def confirm_friend
    friend = current_user.friends.where(friend_id: params[:friend_id])[0]
    friend.update(active?: true)
    
    fuser = User.find(params[:friend_id])
    record = fuser.friends.create(friend_id: current_user.id, active?: true)

    if record.save
      Notifier.trigger_FC(fuser.tokens.last.token, current_user)
      Notifier.trigger_FC(current_user.tokens.last.token, fuser)
    end
    
    return render json: {message: "Friendship confirmed"}
  end

  def friend_info
    @user = User.find(params[:friend_id])

    body = Rabl.render(@user, 'me', :view_path => 'app/views/users/', :format => :json)

    return render json: body
  end
end
