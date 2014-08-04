Rails.application.routes.draw do
  
  devise_for :users
  resources :jars do
    resources :contributions
  end
  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end
  root to: "home#welcome"
end

