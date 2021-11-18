Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :bookmark_tasks
    end
  end
  
  resources :tasks, only: [:create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
end
