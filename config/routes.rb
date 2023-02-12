Rails.application.routes.draw do
  resources :clients

  root 'pages#index'

end
