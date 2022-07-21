# frozen_string_literal: true

Rails.application.routes.draw do
  root :to => 'welcome#index'
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :create, :destroy]
    resources :comments, only: [:destroy]
    post "/posts/:id/like" => "posts#like", as: :like
    post "/posts/:id/comment" => "posts#comment", as: :comments
    end
  
  namespace :api do
    namespace :v1 do
      devise_for :users, :skip => [:registrations, :passwords, :confirmations ]
      resources :posts, only: [:index]
    resources :comments, only: [:index, :create]
    end
  end
  
end
