Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users
  get 'add_friend' => 'users#add_friend', as: 'add_friend'
  get 'reject_request' => 'users#reject_request', as: 'reject_request'
  get 'send_request' => 'users#send_request', as: 'send_request'
  get 'notifications' => 'users#notifications', as: 'notifications'
  resources :users, only: [:index, :show, :notifications]

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  namespace :api, default: { format: :json } do
    resources :users, only: [:index, :create]
    resources :posts, only: [:index, :create] do
      resources :comments, only: [:index, :create]
    end
    post '/sign_in', to: 'sessions#create', as: 'user_sign_in'
    delete '/sign_out', to: 'sessions#destroy', as: 'user_sign_out'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
