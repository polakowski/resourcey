# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show create update destroy]
  resources :posts, only: :create
  resources :paginated_posts, only: :index
  resources :most_recent_posts, only: :index
  resources :categories, only: %i[index show]
end
