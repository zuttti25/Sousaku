Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update] 
  resources :relationships, only: [:create, :destroy]
  get "/users/:id/relationships/followers", to: 'relationships#followings', as: 'followings'
  get "/users/:id/relationships/followings", to: 'relationships#followers', as: 'followers'
  resources :messages, only:  [:create]
  resources :rooms, only: [:create, :show, :index]

  #resources :rooms, only: [:show, :index]
  #resources :messages, only: [:create]
  #resources :notifications, only: [:index, :destroy]
  root 'homes#top'
end