Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  resources :movies
  get "up" => "rails/health#show", as: :rails_health_check
end
