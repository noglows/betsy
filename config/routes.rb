Rails.application.routes.draw do

  root 'products#index'

  resources :products do
    post "/reviews/:id/create" , to: "products#review"
  end

  resources :orders, only: [:show, :update]

  resources :users do
    resources :orders
    resources :products
  end

  resources :sessions, :only => [:new, :create]
  delete "/logout", to: "sessions#destroy", as: :logout

end
