Rails.application.routes.draw do
  resources :clients do
    resources :installations, only: %i[new create edit update]
  end

  root 'pages#index'

end
