require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'pages#index'
  get "/dashboard", to: "pages#dashboard"

  devise_for :users
  patch "/users", to: "users#update"
  resources :user_spots, only: [:create, :destroy]

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
