# frozen_string_literal: true

Rails.application.routes.draw do
  root :to => 'welcome#index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :new, :show, :create, :destroy]
  resources :comments, only: [:destroy]
  post "/posts/:id/like" => "posts#like", as: :like
  post "/posts/:id/comment" => "posts#comment", as: :comments
  end
end
