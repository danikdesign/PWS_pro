Rails.application.routes.draw do
  resources :clients, only: %i[new create]

  root 'pages#index'

end
