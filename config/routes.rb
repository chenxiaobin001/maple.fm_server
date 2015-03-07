Rails.application.routes.draw do


  get 'gcm_app/index'

  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :notifications
  get 'notification/index', to: 'notifications#index'
  get 'notification/index1', to: 'notifications#index1'
  get 'notification/push', to: 'notifications#push'


  #settings
  get 'config/index'
  get 'config/gcm/index' , to: 'gcm_app#index'
  get 'config/gcm/new', to: 'gcm_app#new'
  get 'config/gcm/show', to: 'gcm_app#show'
  get 'config/gcm/edit', to: 'gcm_app#edit'

end
