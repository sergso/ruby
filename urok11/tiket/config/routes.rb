Rails.application.routes.draw do
  resources :r_stations
  resources :routes
  get 'welcome/index'
  root 'welcome#index'
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
