Rails.application.routes.draw do
  get 'user/show'
  get 'user/edit'
  get 'homes/top'
  devise_for :users

  root 'homes#top'
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
