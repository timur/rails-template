Rails.application.routes.draw do

  # all from here only for examle stuff
  resources :pictures
  resources :users
  resources :dashboard, only: [:index]
  get 'landing', to: 'public/landing_page#index'
  get 'animation', to: 'animation#index'

  namespace :examples do
    get '/calendar/month', to: 'calendar#month'
    get '/calendar/year', to: 'calendar#year'
    get '/calendar/datepicker', to: 'calendar#datepicker'
    post '/create_datepicker', to: 'calendar#datepicker_create'
  end

  post '/dashboard', to: 'dashboard#create'
  post '/dashboard/fields', to: 'dashboard#fields'
  get '/home', to: 'home#index'

  # get importmap stuff
  get '/map', to: 'home#map'

  # This are the standard routes for the calendar pagination
  get '/calendar/month_picker', to: 'calendar#month_picker'
  get '/calendar/year', to: 'calendar#year'
  get '/calendar/datepicker', to: 'calendar#datepicker'
  get '/calendar/custom', to: 'calendar#custom'

  resource :flash_message, controller: 'flash_message', only: %i[create]

  namespace :api do
    resources :widget_form, only: %i[ new create ]
  end

  resources :team, only: [:index]
  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
end
