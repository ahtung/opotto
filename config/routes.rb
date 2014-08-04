Rails.application.routes.draw do
  
  devise_for :users
  resources :jars do
    resources :contributions
  end

  get 'home/index'
  get 'home/welcome'    
  
  root to: 'home#welcome'

end

