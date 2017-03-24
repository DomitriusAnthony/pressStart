Rails.application.routes.draw do
  resources :posts do
  	resources :comments
  end
  
  devise_for :users, controllers: { :registrations => "registrations" } do 
    	resources :users, :only => [:show]
    end

  get 'users/:id/follow' => 'users#follow', as: "user_follow"
  get 'users/:id/follow/destroy' => 'users#destroy', as: "destroy_user_follow"
  
  root to: "home#index"

  get "/users/:id", to: "users#show", :as => :user
 end
