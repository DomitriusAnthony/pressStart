Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  resources :posts do
  	resources :comments
    resources :users
  end

  post "/posts/:id/comments" => "comments#create"
  
  devise_for :users, controllers: { :registrations => "registrations" } do 
    	resources :users, :only => [:show]
      resources :posts, :only => [:index]
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
  
  get '/posts/like/:id', to: 'posts#upvote', as: 'post_upvote'

  get '/posts/unlike/:id', to: 'posts#downvote', as: 'post_downvote'

  get 'users/inbox/:id' => "inbox#inbox"

  get '/streams' => "users#streams"

 end

