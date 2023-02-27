Rails.application.routes.draw do

  resources :clients do
    resources :installations, only: %i[new create edit update]
    resources :services, only: %i[new create edit update]
  end

  resources :services, only: %i[new create edit update] do
    resources :tickets
  end

  resources :installations, only: %i[new create edit update] do
    resources :tickets
  end

  root 'pages#index'

end
