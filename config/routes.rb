Rails.application.routes.draw do
  resources :pictures
  resources :users
  resources :dashboard, only: [:index]
  post '/dashboard', to: 'dashboard#create'
  get '/home', to: 'home#index'
  get '/map', to: 'home#map'

  namespace :api do
    resources :widget_form, only: %i[ new create ]
  end

  resources :team, only: [:index]
  get "up" => "rails/health#show", as: :rails_health_check

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  root 'dashboard#index'
end
