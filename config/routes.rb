Rails.application.routes.draw do
  # all from here only for examle stuff
  resources :pictures do
    collection do
      patch :unselect_all
      delete :destroy_selected
    end
    member do
      get :render_picture
    end
  end

  resources :users
  resources :dashboard, only: [:index]
  get 'landing', to: 'public/landing_page#index'
  get 'animation', to: 'animation#index'

  namespace :examples do
    get '/calendar/month', to: 'calendar#month'
    get '/calendar/year', to: 'calendar#year'
    get '/calendar/datepicker', to: 'calendar#datepicker'
    post '/create_datepicker', to: 'calendar#datepicker_create'
    resources :employees
    resources :people
    get '/morph', to: 'morph#index'
    get '/snippets', to: 'snippets#index'
    get '/snippets/buttons', to: 'snippets#buttons'
    get '/snippets/forms', to: 'snippets#forms'
    post '/snippets/forms', to: 'snippets#create'
    post '/snippets/fields', to: 'snippets#fields'
    get '/picture', to: 'upload#picture'
    get '/glitch', to: 'upload#glitch'
    post '/upload/picture', to: 'upload#create'
    get '/ahoy', to: 'ahoy#index'
  end

  # importmap stuff
  get '/home', to: 'home#index'

  # get importmap stuff
  get '/map', to: 'home#map'

  # This are the standard routes for the calendar pagination
  get '/calendar/month_picker', to: 'calendar#month_picker'
  get '/calendar/year', to: 'calendar#year'
  get '/calendar/datepicker', to: 'calendar#datepicker'
  # This is an example for a custom controller
  get '/calendar/custom', to: 'calendar#custom'

  resource :flash_message, controller: 'flash_message', only: %i[create]

  namespace :api do
    resources :widget_form, only: %i[ new create ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root 'dashboard#index'
end
