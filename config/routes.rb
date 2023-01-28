Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end

  root 'users#index'

  resources :posts, only: [:new, :create]

  #get "/users/:id", to: "users#show"
  # Defines the root path route ("/")
  # root "articles#index"
end
