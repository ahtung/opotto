require 'sidekiq/web'

Rails.application.routes.draw do
  mount_roboto

  get 'payments/success'
  get 'payments/failure'

  constraints(format: 'xml') do
    get '/sitemap', to: redirect('https://s3.eu-central-1.amazonaws.com/opotto/sitemaps/sitemap.xml.gz')
  end

  # User
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show

  # Jars
  resources :jars, except: [:index, :destroy] do
    resources :contributions, only: [:new, :create]
  end

  # Authenticated
  authenticated :user, -> (u) { u.admin? } do
    # Sidekiq
    mount Sidekiq::Web => '/sidekiq'
    root to: 'users#show', as: :authenticated_root
  end

  # Non-Authenticated
  root to: 'home#index'
end
