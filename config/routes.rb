Rails.application.routes.draw do
  get 'departments/new'
  get 'departments/edit'
  get 'departments/index'
  get 'departments/show'
  get 'user_companies/find', controller: 'user_companies', action: 'find'
  post 'user_companies/find', controller: 'user_companies', action: 'search_by_email'
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'home#index'
  resources :projects
  resources :departments
end

