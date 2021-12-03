Rails.application.routes.draw do
  resources :pins
  devise_for :users
  resources :requests
  get 'home/index'
  root 'home#index'
  get 'home/see_requests'
  get "admin/users", to: "admin#users"
  delete '/admin/users/:id' => 'admin#users_destroy'
  delete '/admin/requests/:id' => 'admin#requests_destroy'
  get "admin/requests", to: "admin#requests"
  get "payment/success/:id", to: "payment#success"
  get "payment/cancel/:id", to: "payment#cancel"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
