require 'sidekiq/web'

Rails.application.routes.draw do
  mount_roboto

  get 'payments/success'
  get 'payments/failure'
  get 'languages/tr'
  get 'languages/en'

  constraints(format: 'xml') do
    get '/sitemap', to: redirect('https://s3.eu-central-1.amazonaws.com/opotto/sitemaps/sitemap.xml.gz')
  end

  # User
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show

  # Pots
  resources :pots, except: :index do
    member do
      get 'report'
    end
    resources :contributions, only: [:new, :create]
  end

  # Authenticated
  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  # Sidekiq
  authenticated :user, -> (u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Non-Authenticated
  root to: 'home#index'
end
