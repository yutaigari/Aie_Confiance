Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations'} 
  #user編集後にusers/showに飛ばすためにusers/registrationsでafter_update_path_for(resource)を定義したので設定を変更する必要がある
  
  root "top#index"
  
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
