Feedback::Engine.routes.draw do
  root to: 'index#show'

  resource :index, only: %i[show]

  resources :posts, only: %i[index new create show] do
    post :synchronize
    resources :comments, only: %i[index new create]
  end

  resources :comments, only: %i[show]

  resources :notifications, only: %i[index show destroy]
end
