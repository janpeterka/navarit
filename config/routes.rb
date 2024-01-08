# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  mount Feedback::Engine, at: '/feedback'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resource :dashboard, only: :show
  resource :index, only: :show

  resources :daily_plan_recipes do
    patch :sort
    patch :move
  end
  resources :daily_plans, only: %i[show edit update] do
    resources :tasks, controller: 'daily_plan_tasks'
  end

  resources :events do
    resources :duplications, controller: 'event_duplications', only: %i[new create]
    resource :shopping_list, controller: 'event_shopping_lists', only: %i[show]
    resource :cookbook, controller: 'event_cookbooks', only: %i[show]
    # resource :attendance, controller: 'event_attendances', only: %i[index]
    resources :attendees, controller: 'event_attendees', only: %i[index new create update destroy]
    resources :portion_types, controller: 'event_portion_types', only: %i[index new create update destroy]
  end
  resources :published_events, only: %i[show create destroy]
  resources :archived_events, only: %i[create destroy]

  resources :recipes do
    resources :duplications, controller: 'recipe_duplications', only: %i[create]
    resources :tasks, controller: 'recipe_tasks'
  end

  resources :published_recipes, only: %i[index create destroy]
  resources :liked_recipes, only: %i[index create destroy]

  resources :recipe_ingredients
  resources :ingredients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'index#show'
end
