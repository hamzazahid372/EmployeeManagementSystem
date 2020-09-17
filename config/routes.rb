Rails.application.routes.draw do
  get 'user_companies/find', controller: 'user_companies', action: 'find'
  post 'user_companies/search_by_email', controller: 'user_companies', action: 'search_by_email'
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'home#index'
end
