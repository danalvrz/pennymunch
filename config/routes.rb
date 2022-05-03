Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :costs, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  resources :users
  get '/categories/:category_id/costs/:id/update', to:'costs#update_cost', as: "update_cost"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'home', to:'categories#splash', as: 'categories/splash'
  root "categories#index"
end
