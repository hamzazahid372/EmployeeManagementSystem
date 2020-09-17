Rails.application.routes.draw do
  resources :users
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'home#index'
end
