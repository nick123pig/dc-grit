Rails.application.routes.draw do
  resources :projects
  devise_for :users
  resources :users
  resources :user_payments
  root 'projects#index'
end
