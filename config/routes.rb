Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  mount ActionCable.server => '/cable'

  resources :tickets do
    resources :comments, only: [:create]
  end
  resources :votes, only: [:create]

  resources :users, only: [:show]

  patch '/geolocation/:id', to: 'geolocation#update'

  patch '/address_geolocation/:id', to: 'address_geolocation#update'

  resources :dashboards, only: [:index]

  patch 'dashboards/change_role/:id', to: 'dashboards#change_role', as: 'change_role_dashboards'

  resources :hubs, only: [:index]
end
