Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
    controllers tokens: 'auths'  
  end

  resources :posts
end
