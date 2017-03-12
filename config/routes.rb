Rails.application.routes.draw do
  root to: 'pages#index'
  get "/dashboard", to: "pages#dashboard"
  resources :user_spots, only: [:create, :destroy]
  patch "/users", to: "users#update"
  devise_for :users
end
