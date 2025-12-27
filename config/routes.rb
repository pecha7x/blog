Rails.application.routes.draw do
  devise_for :admin_users, path: "auth", skip: %i[registrations]

  namespace :admin do
    resources :articles
  end

  resources :articles, only: %i[index show]

  get "up" => "rails/health#show", as: :rails_health_check

  root "articles#index"
end
