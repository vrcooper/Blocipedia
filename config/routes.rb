Rails.application.routes.draw do
  
  get 'wikis/create'

  devise_for :users
  resources :users, only: [:show] do
    resources :wikis, only: [:create, :destroy]
  end 

  get 'welcome/index'

  authenticated do

    root to: 'users#show', as: :authenticated_root

  end

  unauthenticated do
  
   root to: 'welcome#index'

 end

end