Rails.application.routes.draw do
  devise_for :users
root 'chirps#index'
resources :peeps
end
