Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :notifications
  get 'notification/index', to: 'notifications#index'
end
