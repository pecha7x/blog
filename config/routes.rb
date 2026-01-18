Rails.application.routes.draw do
  devise_for :admin_users, path: "auth", skip: %i[registrations]

  namespace :admin do
    resources :articles
    resource :dashboard, only: :show
    resources :categories
  end

  resources :categories, only: :show do
    resources :articles, only: :show
  end

  root 'static_pages#about'

  get "up" => "rails/health#show", as: :rails_health_check

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/home', to: 'static_pages#home'
end
