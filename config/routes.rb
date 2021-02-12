Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :boards
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update] 
  resources :relationships, only: [:create, :destroy]
  get "/users/:id/relationships/followers", to: 'relationships#followings', as: 'followings'
  get "/users/:id/relationships/followings", to: 'relationships#followers', as: 'followers'
  resources :messages, only:  [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :notifications, only: [:index, :destroy]

  #resources :rooms, only: [:show, :index]
  #resources :messages, only: [:create]
  root 'homes#top'
end