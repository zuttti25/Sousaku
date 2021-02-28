Rails.application.routes.draw do

  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:'users/sessions'
  }
  
  
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  
  get "/posts/pickup", to: 'posts#pickup', as: 'pickup'
  get "/posts/popular", to: 'posts#popular', as: 'popular'
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :new]
  end
  resources :boards
  get "/users/:id/mypost", to: 'users#mypost', as: 'mypost'
  get "/users/:id/mylike", to: 'users#mylike', as: 'mylike'
  resources :users, only: [:index, :show, :edit, :update] 
  resources :relationships, only: [:create, :destroy]
  get "/users/:id/relationships/followers", to: 'relationships#followings', as: 'followings'
  get "/users/:id/relationships/followings", to: 'relationships#followers', as: 'followers'
  resources :messages, only:  [:create, :destroy]
  resources :rooms, only: [:create, :show, :index]
  resources :notifications, only: [:index, :destroy]
  get "search" => "users#search"
  get "top" => "homes#top"
  root 'homes#about'
end