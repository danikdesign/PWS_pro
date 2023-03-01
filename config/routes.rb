Rails.application.routes.draw do

  resources :clients do
    resources :installations, only: %i[new create edit update]
    resources :services, only: %i[new create edit update]
  end

  resources :services, only: %i[new create edit update] do
    resources :tickets, only: %i[new create edit update]
  end

  resources :installations, only: %i[new create edit update] do
    resources :tickets, only: %i[new create edit update]
  end

  resources :tickets, only: %i[index show]

  root 'pages#index'

end
