Rails.application.routes.draw do
  devise_for :users
  
  namespace :admin do
    resources :posts, only: [:index, :update]
    root to: 'posts#index'
  end

  root 'posts#index'
  resources :posts do
    collection do
      get 'my_posts'
    end
  end
end