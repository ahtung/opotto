require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :jars, except: :index do
    resources :contributions, only: [:new, :create]
  end
  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end
  root to: "home#welcome"
end

