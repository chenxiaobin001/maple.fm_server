Rails.application.routes.draw do


#  devise_for :users, :controllers => { :registrations => "users/registrations" }
#  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  devise_for :users, :controllers => {registrations: 'registrations'}
  get 'gcm_app/index'

  root to: 'visitors#index'
#  devise_for :users
  resources :users
  resources :notifications
  resources :messages, :only => [:index, :show]
  get 'notification/index', to: 'notifications#index'
  get 'notification/index1', to: 'notifications#index1'


  #admin
  get 'admin/index', to: 'admin#index'

  #users
  get '/user/json/signUp', to: 'users#jsonSignUp'
  get '/user/json/signUpFail', to: 'users#jsonSignUpFail'
  get '/user/json/update', to: 'users#jsonUpdate'

  #messages
  get 'message/push', to: 'messages#push'
  get 'messages/index'
  get 'users/:id/messages', to: 'users#messages'

  #settings
  get 'config/gcm/' , to: 'gcm_app#index'
  get 'config/gcm/new', to: 'gcm_app#new'
  get 'config/gcm/:id', to: 'gcm_app#show'
  get 'config/gcm/:id/edit', to: 'gcm_app#edit'
  put 'config/gcm/:id', to: 'gcm_app#update'

end
