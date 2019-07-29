class UsersController < ApplicationController

  def index
    @users = User.all.order(id: :desc)

    body = Rabl.render(@users, 'index', :view_path => 'app/views/users/', :format => :json)

    return render json: body
  end

  def search
    @users = current_user.search(params[:search])

    body = Rabl.render(@users, 'index', :view_path => 'app/views/users/', :format => :json)

    return render json: body
  end

  def me
    @user = current_user

    body = Rabl.render(@user, 'me', :view_path => 'app/views/users/', :format => :json)
    
    return render json: body
  end

  def update_user
    current_user.update(permit_params)
    
    return render json: current_user
  end

  private

  def permit_params
    params.require(:user).permit(:first_name, :last_name, image_attributes: [:file])
  end
end
