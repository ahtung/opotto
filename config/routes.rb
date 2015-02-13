Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :jars do
    resources :contributions
  end
  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end
  root to: "home#welcome"
end

