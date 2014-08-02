Rails.application.routes.draw do
  get 'contributions/new'

  get 'contributions/create'

  get 'contributions/update'

  get 'contributions/edit'

  get 'contributions/destroy'

  get 'contributions/index'

  get 'contributions/show'

  root to: 'home#index'
  get 'home/index'

  devise_for :users

  resources :jars do
    resources :contributions
  end
end

