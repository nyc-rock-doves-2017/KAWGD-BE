Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :orders, except: [:destroy]
  resources :sessions, only: [:index, :login]

  root to: 'sessions#index'
end
