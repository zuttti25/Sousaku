Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  root 'homes#top'
  get 'homes/top'
  resources :users, only: [:show, :edit, :update] 
  #do
  # resource :relationships, only: [:create, :destroy]
    # get :follows, on: :member
    # get :followers, on: :member
  # end
  #resources :rooms, only: [:show, :index]
  #resources :messages, only: [:create]
  #resources :notifications, only: [:index, :destroy]
end
