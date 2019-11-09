Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations'} 
  #user編集後にusers/showに飛ばすためにusers/registrationsでafter_update_path_for(resource)を定義したので設定を変更する必要がある
  
  root "top#index"
  
  resources :users, only: [:show, :index]
  resources :post_images, only: [:new, :create, :destroy, :index, :show] do 
    resource :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
