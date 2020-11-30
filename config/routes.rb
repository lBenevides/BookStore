Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'books#index'
  
  resources :books
  resources :users do
    resources :carts
  end


  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

end
