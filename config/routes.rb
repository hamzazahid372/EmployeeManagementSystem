Rails.application.routes.draw do
  resources :users
  resources :projects
  resources :users do
    resources :comments, shallow: true
    resources :attachments, shallow: true
    collection do
      get 'search'
    end
  end
  resources :projects do
    resources :projects_users, shallow: true
    resources :comments, shallow: true
    resources :attachments, shallow: true
  end
  get 'user_companies/find', controller: 'user_companies', action: 'find'
  post 'user_companies/find', controller: 'user_companies', action: 'search_by_email'
  devise_for :user, controllers: { registrations: 'registrations', sessions: 'sessions' }
  root to: 'home#index'
  resources :departments
  resources :tasks
  resources :teams do
    resources :users_teams, shallow: true
    resources :comments, shallow: true
  end
  resources :tasks do
    resources :time_logs
    resources :comments, shallow: true
    resources :attachments, shallow: true
  end
end
