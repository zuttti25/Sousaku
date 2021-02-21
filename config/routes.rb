Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :new]
  end
  
  resources :boards
  get "/users/:id/mypost", to: 'users#mypost', as: 'mypost'
  get "/users/:id/mylike", to: 'users#mylike', as: 'mylike'
  resources :users, only: [:show, :edit, :update] 
  resources :relationships, only: [:create, :destroy]
  get "/users/:id/relationships/followers", to: 'relationships#followings', as: 'followings'
  get "/users/:id/relationships/followings", to: 'relationships#followers', as: 'followers'
  resources :messages, only:  [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :notifications, only: [:index, :destroy]
  get "search" => "users#search"
  root 'homes#top'
end