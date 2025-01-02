# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get "changelog", to: "index#changelog"

  concern :multiselect_chips do
    collection do
      post :multiselect_chips
    end
  end

  resource :dashboard, only: :show
  resource :index, only: :show

  resource :user_settings, only: :show

  resources :daily_plan_recipes, only: %i[create update destroy] do
    patch :sort
    patch :move
  end
  resources :daily_plans, only: %i[show edit update] do
    resources :tasks, controller: "daily_plan_tasks"
  end

  resources :events do
    resources :duplications, controller: "event_duplications", only: %i[new create]
    resource :shopping_list, controller: "event_shopping_lists", only: %i[show]
    resource :cookbook, controller: "event_cookbooks", only: %i[show]
    # resource :attendance, controller: 'event_attendances', only: %i[index]
    resources :attendees, controller: "event_attendees", only: %i[index new create update destroy]
    resources :portion_types, controller: "event_portion_types", only: %i[index new create update destroy]
    resources :collaboration, controller: "event_collaboration", only: %i[index create update destroy]
  end

  resources :published_events, only: %i[show create destroy]
  resources :archived_events, only: %i[create destroy]

  resources :recipes do
    resources :duplications, controller: "recipe_duplications", only: %i[create]
    resources :tasks, controller: "recipe_tasks"
  end

  resources :published_recipes, only: %i[index show create destroy]
  resources :liked_recipes, only: %i[index create destroy]

  resources :recipe_ingredients
  resources :ingredients

  resources :recipe_categories, concerns: :multiselect_chips

  resources :labels, concerns: :multiselect_chips

  namespace :admin do
    resources :common_ingredients, only: %i[index new create destroy]
  end


  get "a/error", to: "admin#error"
  get "a/deny", to: "admin#access_denied"
  get "a/", to: "admin#index"


  resources :common_ingredients, only: %i[show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "index#show"

  mount Feedback::Engine, at: '/feedback'

  authenticate :user, ->(user) { user.admin? } do
    mount Lookbook::Engine, at: "/a/lookbook"
    mount SolidErrors::Engine, at: "/a/solid_errors"
  end

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
