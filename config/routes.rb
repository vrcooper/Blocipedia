Rails.application.routes.draw do
  
  get 'wikis/create'

  devise_for :users

  resources :charges, only:[:new, :create] 

  delete 'charges/downgrade'
  
  resources :wikis
 
  get 'welcome/index'

  authenticated do

    root to: 'wikis#index', as: :authenticated_root

  end

  unauthenticated do
  
   root to: 'welcome#index'

 end

end