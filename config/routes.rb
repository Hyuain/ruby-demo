Rails.application.routes.draw do
  get '/hello', to: 'first#hello'
  get '/hi', to: 'first#hi'
  get '/me', to: 'users#me'
  delete '/sessions', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :records
  resources :sessions, only: %i[create]
  resources :tags
  resources :taggings, except: [:update]
end
