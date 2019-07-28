Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
    controllers tokens: 'auths'  
  end
  
  resources :friends do
    get :invite_friend
    get :confirm_friend
    get :friend_info
    collection do 
      get :requests
    end
  end 
  
  resources :users do
    resources :timeline
    collection do
      get :me
      put :update_user
    end
  end
  
  resources :posts do
    resources :comments
  end
end
