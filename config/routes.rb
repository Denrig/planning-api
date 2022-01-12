# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :rooms, only: %i[create show index] do
        resources :tasks, only: %i[index create update]
      end
      resources :users, only: %i[show update create]
      resources :join_room, only: %i[create show]
      resources :votes, only: %i[create update index] do
        delete '/', action: :destroy, on: :collection
      end
    end
  end
end
