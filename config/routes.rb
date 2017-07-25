Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :orders, except: [:destroy]
  resources :sessions, only: :create
end
