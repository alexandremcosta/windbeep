Rails.application.routes.draw do
  root to: 'pages#index'
  get "/dashboard", to: "pages#dashboard"
  resources :user_spots, only: [:create, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
