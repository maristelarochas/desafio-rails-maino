Rails.application.routes.draw do
  get "comments/create"
  root "pages#home"
  devise_for :users
  resources :movies do
    resources :comments, only: [ :create ]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
