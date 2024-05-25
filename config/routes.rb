Rails.application.routes.draw do
  root 'keywords#index'
  get 'keywords/secret'

  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'user_sessions#new', as: 'login'

  resources :user_sessions, only: [:create, :destroy]
  resources :users, only: [:index, :create, :authenticate]
end
