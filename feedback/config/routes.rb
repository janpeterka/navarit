Feedback::Engine.routes.draw do
  root to: 'post#index'

  resources :post, only: %i[index new create show] do
    resources :comment, only: %i[index new create]
  end
end
