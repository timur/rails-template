Rails.application.routes.draw do
  resources :pictures
  resources :users
  resources :dashboard, only: [:index]

  post '/dashboard', to: 'dashboard#create'
  post '/dashboard/fields', to: 'dashboard#fields'
  get '/home', to: 'home#index'
  get '/map', to: 'home#map'
  get '/calendar', to: 'calendar#index'
  get '/calendar/month', to: 'calendar#month'
  get '/calendar/week', to: 'calendar#week'
  get '/calendar/year', to: 'calendar#year'
  get '/calendar/datepicker', to: 'calendar#datepicker'
  get '/calendar/datepicker_paginate', to: 'calendar#datepicker_paginate'

  post '/datepicker', to: 'datepicker#create'

  resource :flash_message, controller: 'flash_message', only: %i[create]

  namespace :api do
    resources :widget_form, only: %i[ new create ]
  end

  resources :team, only: [:index]
  get "up" => "rails/health#show", as: :rails_health_check

  get 'landing', to: 'public/landing_page#index'

  root 'dashboard#index'
end
