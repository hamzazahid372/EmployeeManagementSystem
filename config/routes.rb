Rails.application.routes.draw do
  get 'event/index'
  get 'event/show'
  get 'event/new'
  get 'event/edit'
  resources :users
  resources :projects
  resources :events
  get 'user_companies/find', controller: 'user_companies', action: 'find'
  post 'user_companies/find', controller: 'user_companies', action: 'search_by_email'
  devise_for :user, controllers: { registrations: 'registrations', sessions: 'sessions' }
  root to: 'home#index'
end
