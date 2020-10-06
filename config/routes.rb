Rails.application.routes.draw do
  resources :events
  resources :users do
    resources :comments, shallow: true
    resources :attachments, shallow: true
    collection do
      get 'search'
    end
    member do
      get 'change_password'
      post 'update_password'
    end
  end
  resources :projects do
    resources :projects_users, shallow: true
    resources :comments, shallow: true
    resources :attachments, shallow: true
    collection do
      get 'search'
    end
  end
  devise_for :user, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :departments do
    resources :comments, shallow: true
    resources :projects_departments, shallow: true
  end
  resources :teams do
    resources :users_teams, shallow: true
    resources :comments, shallow: true
    collection do
      get 'search'
    end
  end
  resources :tasks do
    resources :time_logs, shallow: true
    resources :comments, shallow: true
    resources :tasks_watchers, shallow:true
    resources :attachments, shallow: true
  end
  resources :company_settings
  resources :working_days
  resources :holidays

  get 'reports/tasks'
  get 'reports/time_logs'
  get 'reports/task_audits'
  get 'reports/attendance_report'
  post 'attendance/log_in'
  post 'attendance/log_out'
  get 'user_companies/find', controller: 'user_companies', action: 'find'
  post 'user_companies/find', controller: 'user_companies', action: 'search_by_email'
  get 'user_companies/index', controller: 'user_companies', action: 'index'
  root to: 'home#index'
end
