Rails.application.routes.draw do
  resources :causes
  devise_for :users
  resources :users
  resources :user_payments
  root 'causes#index'
end
