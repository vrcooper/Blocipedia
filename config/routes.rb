Rails.application.routes.draw do
  

  devise_for :users

  resources :charges, only:[:new, :create] 

  delete 'charges/downgrade'
  
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
 
  get 'welcome/index'

  authenticated do

    root to: 'wikis#index', as: :authenticated_root

  end

  unauthenticated do
  
   root to: 'welcome#index'

 end

end