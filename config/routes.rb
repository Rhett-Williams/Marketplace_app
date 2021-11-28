Rails.application.routes.draw do
  resources :pins
  devise_for :users
  resources :requests
  get 'home/index'
  root 'home#index'
  get 'home/see_requests'
  scope "admin" do
    get "users", to: "users#index"
    get "users/:id", to: "users#show", as: "user"
    delete "users/:id", to: "users#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
