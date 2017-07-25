Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :orders, except: [:destroy]
  resources :sessions, only: [:index, :create]
  post '/login', to: 'sessions#create'

  root to: 'sessions#index'
end
