Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  resources :posts do
  	resources :comments
  end
  
  devise_for :users, controllers: { :registrations => "registrations" } do 
    	resources :users, :only => [:show]
    end

  get 'users/:id/follow' => 'users#follow', as: "user_follow"
  get 'users/:id/follow/destroy' => 'users#destroy', as: "destroy_user_follow"
  
  root to: "posts#index"

  get "/users/:id", to: "users#show", :as => :user
 
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  get 'users/:id/inbox' => "inbox#inbox"
 end

