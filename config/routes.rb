# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :webhooks, only: :create
      resources :users, only: %i[show update create]
      resources :join_room, only: %i[create show] do
        delete '/', action: :destroy, on: :collection
      end
      resources :votes, only: %i[create update index] do
        delete '/', action: :destroy, on: :collection
      end
      resources :rooms, only: %i[create show index] do
        resources :tasks, only: %i[index create update show]
      end
    end
  end
end
