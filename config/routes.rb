Rails.application.routes.draw do
  root 'keywords#index'
  get 'keywords/secret'
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :authenticate]
end
