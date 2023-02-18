Rails.application.routes.draw do
  resources :clients do
    resources :installations, only: %i[create, update]
  end

  root 'pages#index'

end
