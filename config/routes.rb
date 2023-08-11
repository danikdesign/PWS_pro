# frozen_string_literal: true
require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    passwordless_for :users, at: '/', as: :auth
    mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new

    resources :clients do
      resources :installations, only: %i[new create edit update update_from_ticket]
      resources :services, only: %i[new create edit update]
    end

    resources :services, only: %i[new create edit update] do
      resources :tickets, only: %i[new create edit update destroy]
    end

    resources :installations, only: %i[new create edit update update_from_ticket] do
      member do
        patch :update
        patch :update_from_ticket
      end
      resources :tickets, only: %i[new create edit update destroy]
    end

    resources :tickets, only: %i[index show]

    root 'pages#index'

    get 'services_calendar', to: 'pages#services_calendar'
  end
end
