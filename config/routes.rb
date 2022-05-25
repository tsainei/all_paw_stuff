Rails.application.routes.draw do
  get 'reservations/index'
  get 'reservations/show'
  get 'reservations/new'
  get 'reservations/create'
  get 'reservations/destroy'
  get 'reservations/update'
  get 'reservations/edit'
  devise_for :users
  root to: 'pages#home'
  resources :accessories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
