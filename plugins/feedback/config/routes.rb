Feedback::Engine.routes.draw do
  root to: 'index#show'

  resource :index, only: %i[show]

  resources :posts, only: %i[index new create show] do
    post :synchronize
    resources :comments, only: %i[index new create]
  end

  resources :comments, only: %i[show]

  resources :notifications, only: %i[index show destroy]

  namespace :admin do
    resources :posts, only: %i[index] do
      member do
        post :close
        post :complete
        post :open
        post :reopen
      end
    end
  end
end
