require 'sidekiq/web'

Rails.application.routes.draw do

  resources :notifications, only: [:index, :update]
  resources :posts
  resources :usuarios, as: :users, only: [:update, :show]
  resources :friendships, only: [:create, :update, :index]
  #
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"
  
  # get 'main/home'
  
  authenticated :user do
    root 'main#home'
  end

  unauthenticated :user do
    root 'main#unregistered'
  end

   # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  mount ActionCable.server => '/cable' 
  mount Sidekiq::Web => '/sidekiq'
  
        # ActionCable.server.config.disable_request_forgery_protection = true 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
