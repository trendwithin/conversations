Rails.application.routes.draw do
  resources :follows
  devise_for :users
root 'chirps#index'
end
