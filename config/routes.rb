Rails.application.routes.draw do

  root 'products#index'

  resources :products do
    get "/reviews/:id/create" , to: "products#review"
  end

  resources :orders, only: [:show, :update]

  resources :users do
    resources :orders
    resources :products
  end

end
