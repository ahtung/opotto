require 'sidekiq/web'

Rails.application.routes.draw do

  # Users
  devise_for :users, skip: [:sessions], controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Pages
  get '/discover' => 'home#index', as: :discover

  # Jars
  resources :jars, except: [:index, :destroy] do
    resources :contributions, only: [:new, :create]
  end

  # Authenticated
  authenticated :user do
    # Sidekiq
    mount Sidekiq::Web => '/sidekiq'

    # Root
    root to: "home#index", as: :authenticated_root
  end

  # Root
  root to: "home#welcome"
end

