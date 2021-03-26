Rails.application.routes.draw do
  root to: 'toppages#index'


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #個別に変えることでURLのところが指定したものになるので変えたい時には個別に変える
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do 
      get :followings
      get :followers
    end
  end

  resources :users, only: [:index, :show, :create] do
    member do
      get :likes
    end
  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
