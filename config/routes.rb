Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tickets do
    resources :comments, only: [:create]
  end
  resources :votes, only: [:create]

  resources :users, only: [:show]

  resources :dashboards, only: [:index]
end
