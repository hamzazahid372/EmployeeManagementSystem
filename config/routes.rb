Rails.application.routes.draw do
  get 'try/index'
  root to: 'home#index'
  get 'new/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
