Feedback::Engine.routes.draw do
  root to: 'posts#index'

  resources :posts, only: %i[index new create show] do
    post :synchronize
    resources :comments, only: %i[index new create]
  end
end
