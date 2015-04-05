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
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  resources :users, only: :show

  # Discover
  # TODO: (dunyakirkali) move to high voltage?
  get '/discover' => 'home#index', as: :discover

  # Jars
  resources :jars, except: [:index, :destroy] do
    resources :contributions, only: [:new, :create]
  end

  # Authenticated
  authenticated :user do
    # Sidekiq
    mount Sidekiq::Web => '/sidekiq'
    root to: 'home#index', as: :authenticated_root
  end

  # Non-Authenticated
  root to: 'home#welcome'
end
