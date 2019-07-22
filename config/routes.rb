Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
    controllers tokens: 'auths'  
  end
  
  resources :friends
  
  resources :users do 
    collection do
      get :show
    end
    resources :timeline
  end
  
  resources :posts do
    resources :comments
  end
end
