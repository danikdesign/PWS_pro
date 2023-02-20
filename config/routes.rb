Rails.application.routes.draw do

  resources :clients do
    resources :installations, only: %i[new create edit update]
    resources :services, only: %i[new create edit]
  end

  root 'pages#index'

end
