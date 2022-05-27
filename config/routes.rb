Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :accessories
  resources :accessories, except: %i[edit update] do
    resources :reservations, only: %i[new create]
    get :mine, on: :collection
  end
  resources :reservations, only: [:destroy] do
    get :mine, on: :collection
    # /reservations/new/tomorrow  on: :new
    # /reservations/tomorrow  on: :collection
    # /reservations/:id/details  on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
