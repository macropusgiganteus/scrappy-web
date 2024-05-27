Rails.application.routes.draw do
  root 'keywords#index'
  
  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'user_sessions#new', as: 'login'
  
  get '/keywords/:id', to: 'keywords#show', as: 'keyword'
  post 'import_keywords', to: 'keywords#import_csv'

  resources :user_sessions, only: [:create, :destroy]
  resources :users, only: [:index, :create, :authenticate]
  resources :keywords, only: [:index, :show]
end
