require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/discover' => 'home#index', as: :discover

  resources :jars, except: [:index, :destroy] do
    resources :contributions, only: [:new, :create]
  end
  authenticated :user do
    mount Sidekiq::Web => '/sidekiq'
    root to: "home#index", as: :authenticated_root
  end
  root to: "home#welcome"
end

