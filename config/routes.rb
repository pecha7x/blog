Rails.application.routes.draw do
  devise_for :admin_users, path: "auth", skip: %i[registrations]

  namespace :admin do
    resources :articles
    resource :dashboard, only: :show
  end

  resources :articles, only: %i[index show]
  resources :categories, only: :show

  get "up" => "rails/health#show", as: :rails_health_check
  get "home/index"

  root "home#index"
end
