Rails.application.routes.draw do
  resources :causes
  devise_for :users
  resources :users
  root 'causes#index'
  resources :user_payments

end
