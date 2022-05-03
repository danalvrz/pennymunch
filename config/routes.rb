Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :costs#, only: [:index, :new, :create, :destroy]
  end
  resources :users
  #get '/categories/:category_id/costs', to: 'costs#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "categories#index"
end
